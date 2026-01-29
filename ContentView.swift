//
//  ContentView.swift
//  PhoneHasher
//
//  Main UI matching inspiration screenshot
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()
    @State private var isProcessing = false
    @State private var showingResults = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                HeaderView()

                VStack(spacing: 20) {
                    // Section 1: Select Files
                    SectionCard(number: 1, title: "Select CSV Files") {
                        FileSelectionView(appState: appState)
                    }

                    // Section 2: Choose Hash Formats
                    SectionCard(number: 2, title: "Choose Hash Formats") {
                        HashFormatView(appState: appState)
                    }

                    // Section 3: Output Settings
                    SectionCard(number: 3, title: "Output Settings") {
                        OutputSettingsView(appState: appState)
                    }

                    // Section 4: Output Folder
                    SectionCard(number: 4, title: "Output Folder") {
                        OutputFolderView(appState: appState)
                    }

                    // Process Button
                    ProcessButtonView(appState: appState, isProcessing: $isProcessing, showingResults: $showingResults)

                    // Progress/Status
                    StatusView(appState: appState)
                }
                .padding(20)
            }
        }
        .background(Color(hex: "f8fafc"))
        .alert("Processing Complete", isPresented: $showingResults) {
            Button("OK", role: .cancel) {}
        } message: {
            if case .completed(let results) = appState.processingState {
                Text("""
                ✅ All files processed successfully!

                Total Files: \(results.totalFiles)
                Total Rows: \(results.totalRows)
                Successful: \(results.successfulRows)
                Errors: \(results.errorRows)

                Output: \(results.outputPath)
                """)
            }
        }
    }
}

// MARK: - Header View
struct HeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                // Logo
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.3), Color.white.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 48, height: 48)

                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }

                Text("Phone Number Hasher")
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
            }

            Text("Secure SHA-256 hashing for phone numbers")
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(
            LinearGradient(colors: [Color(hex: "1e3a8a"), Color(hex: "1e40af")],
                         startPoint: .leading, endPoint: .trailing)
        )
    }
}

// MARK: - Section Card
struct SectionCard<Content: View>: View {
    let number: Int
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color(hex: "2563eb"))
                        .frame(width: 36, height: 36)
                    Text("\(number)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }

                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "1e293b"))

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(Color(hex: "f9fafb"))

            // Content
            VStack(alignment: .leading, spacing: 0) {
                content
            }
            .padding(28)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - File Selection View
struct FileSelectionView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Info box
            InfoBox(text: "Select up to 10 CSV files to process. Files will be hashed in all selected formats.")

            // Clickable file display box
            Button(action: selectFiles) {
                VStack {
                    Image(systemName: "folder.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color(hex: "94a3b8"))

                    if appState.selectedFiles.isEmpty {
                        Text("No files selected")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "94a3b8"))

                        Text("(Click to browse)")
                            .font(.system(size: 10))
                            .foregroundColor(Color(hex: "94a3b8"))
                            .padding(.top, 2)
                    } else {
                        Text("\(appState.selectedFiles.count) file(s) selected")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(Color(hex: "2563eb"))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color(hex: "f1f5f9"))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(hex: "e5e7eb"), lineWidth: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(Rectangle())

            // File preview table
            if !appState.fileInfos.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Selected Files:")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(hex: "1e293b"))

                    VStack(spacing: 0) {
                        // Table header
                        HStack {
                            Text("File Name")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(Color(hex: "64748b"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Rows")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(Color(hex: "64748b"))
                                .frame(width: 100, alignment: .trailing)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(hex: "f1f5f9"))

                        // Table rows
                        ForEach(appState.fileInfos) { fileInfo in
                            HStack {
                                Text(fileInfo.fileName)
                                    .font(.system(size: 11))
                                    .foregroundColor(Color(hex: "1e293b"))
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(fileInfo.formattedRowCount)
                                    .font(.system(size: 11, design: .monospaced))
                                    .foregroundColor(fileInfo.isCountingRows ? Color(hex: "94a3b8") : Color(hex: "2563eb"))
                                    .frame(width: 100, alignment: .trailing)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.white)

                            if fileInfo.id != appState.fileInfos.last?.id {
                                Divider()
                            }
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(hex: "e5e7eb"), lineWidth: 1)
                    )
                    .cornerRadius(6)
                }
            }

            // Clear button (only if files selected)
            if !appState.selectedFiles.isEmpty {
                Button(action: clearSelection) {
                    Text("Clear Selection")
                        .font(.system(size: 12, weight: .semibold))
                }
                .buttonStyle(SecondaryButtonStyle())
            }
        }
    }

    func selectFiles() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.commaSeparatedText, .plainText]
        panel.message = "Select CSV files (max 10)"

        if panel.runModal() == .OK {
            let selected = panel.urls.prefix(10)
            appState.selectedFiles = Array(selected)

            // Create FileInfo objects and count rows
            appState.fileInfos = selected.map { FileInfo(url: $0, rowCount: nil, isCountingRows: true) }

            // Count rows asynchronously
            Task {
                for index in appState.fileInfos.indices {
                    let url = appState.fileInfos[index].url
                    let count = await Task.detached {
                        HashProcessor.countRows(in: url)
                    }.value

                    await MainActor.run {
                        appState.fileInfos[index].rowCount = count
                        appState.fileInfos[index].isCountingRows = false
                    }
                }
            }
        }
    }

    func clearSelection() {
        appState.selectedFiles.removeAll()
        appState.fileInfos.removeAll()
    }
}

// MARK: - Hash Format View
struct HashFormatView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            InfoBox(text: "Select one or more hash formats. Each format creates a separate output folder.")

            VStack(alignment: .leading, spacing: 12) {
                FormatToggle(
                    isOn: $appState.hashFormats.tenDigit,
                    title: "Hash for 3P Platforms (on 10 digits)",
                    hint: "e.g., 9876543210"
                )

                FormatToggle(
                    isOn: $appState.hashFormats.plus91,
                    title: "Hash for 3P Platforms (with +91)",
                    hint: "e.g., +919876543210"
                )

                FormatToggle(
                    isOn: $appState.hashFormats.with91,
                    title: "Hash for 3P Platforms (with 91 & Custom Header)",
                    hint: "e.g., 919876543210"
                )

                FormatToggle(
                    isOn: $appState.hashFormats.truecaller,
                    title: "Hash for Truecaller (with 91 and no header)",
                    hint: "e.g., 919876543210 without header"
                )
            }
        }
    }
}

struct FormatToggle: View {
    @Binding var isOn: Bool
    let title: String
    let hint: String

    var body: some View {
        HStack(spacing: 12) {
            // Toggle first
            Toggle("", isOn: $isOn)
                .toggleStyle(.switch)
                .labelsHidden()

            // Then text
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "1e293b"))
                Text(hint)
                    .font(.system(size: 10))
                    .foregroundColor(Color(hex: "94a3b8"))
            }
        }
    }
}

// MARK: - Output Settings View
struct OutputSettingsView: View {
    @ObservedObject var appState: AppState

    // Check if only Truecaller is selected
    var isOnlyTruecaller: Bool {
        return appState.hashFormats.truecaller &&
               !appState.hashFormats.tenDigit &&
               !appState.hashFormats.plus91 &&
               !appState.hashFormats.with91
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Custom Column Name:")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(isOnlyTruecaller ? Color(hex: "94a3b8") : Color(hex: "1e293b"))

                if isOnlyTruecaller {
                    Text("Not applicable - Truecaller format doesn't use column headers")
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "f59e0b"))
                } else {
                    Text("This column name will be used in output files (except Truecaller format)")
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "64748b"))
                }
            }

            TextField("phone", text: $appState.customColumnName)
                .textFieldStyle(.plain)
                .font(.system(size: 13))
                .padding(11)
                .background(isOnlyTruecaller ? Color(hex: "f3f4f6") : Color(hex: "f9fafb"))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(hex: "e5e7eb"), lineWidth: 1)
                )
                .disabled(isOnlyTruecaller)
                .opacity(isOnlyTruecaller ? 0.5 : 1.0)

            if !isOnlyTruecaller {
                Text("Example: \"phone\", \"contact\", \"mobile_number\"")
                    .font(.system(size: 10, design: .monospaced))
                    .italic()
                    .foregroundColor(Color(hex: "94a3b8"))
            }
        }
    }
}

// MARK: - Output Folder View
struct OutputFolderView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            InfoBox(text: "Select a folder where output files will be organized by hash format.")

            // Clickable folder display box
            Button(action: selectFolder) {
                VStack {
                    Image(systemName: "folder.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color(hex: "94a3b8"))

                    if let folder = appState.outputFolder {
                        Text("✓ \(folder.path)")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "1e293b"))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                    } else {
                        Text("No folder selected")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "94a3b8"))

                        Text("(Click to browse)")
                            .font(.system(size: 10))
                            .foregroundColor(Color(hex: "94a3b8"))
                            .padding(.top, 2)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color(hex: "f1f5f9"))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(hex: "e5e7eb"), lineWidth: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(Rectangle())
        }
    }

    func selectFolder() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.message = "Select output folder"

        if panel.runModal() == .OK {
            appState.outputFolder = panel.url
        }
    }
}

// MARK: - Process Button View
struct ProcessButtonView: View {
    @ObservedObject var appState: AppState
    @Binding var isProcessing: Bool
    @Binding var showingResults: Bool

    var body: some View {
        VStack(spacing: 0) {
            Button(action: processFiles) {
                HStack(spacing: 8) {
                    if isProcessing {
                        ProgressView()
                            .scaleEffect(0.8)
                            .tint(.white)
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                    }
                    Text(isProcessing ? "PROCESSING..." : "PROCESS FILES")
                        .font(.system(size: 14, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
            }
            .buttonStyle(ProcessButtonStyle(enabled: appState.canProcess && !isProcessing))
            .disabled(!appState.canProcess || isProcessing)
            .padding(24)
        }
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    func processFiles() {
        isProcessing = true

        Task {
            let results = await HashProcessor.processFiles(
                files: appState.selectedFiles,
                formats: appState.hashFormats,
                columnName: appState.customColumnName,
                outputFolder: appState.outputFolder!
            ) { current, total, filename, format in
                appState.processingState = .processing(current: current, total: total, filename: filename, format: format)
            }

            await MainActor.run {
                appState.processingState = .completed(results: results)
                isProcessing = false
                showingResults = true
            }
        }
    }
}

// MARK: - Status View
struct StatusView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        VStack(spacing: 8) {
            if case .processing(let current, let total, let filename, let format) = appState.processingState {
                ProgressView(value: Double(current), total: Double(total))
                    .tint(Color(hex: "2563eb"))

                Text("Processing \(filename) → \(format) (\(current)/\(total))")
                    .font(.system(size: 11))
                    .foregroundColor(Color(hex: "64748b"))
            } else if !appState.statusMessage.isEmpty {
                Text(appState.statusMessage)
                    .font(.system(size: 11))
                    .foregroundColor(appState.canProcess ? Color(hex: "10b981") : Color(hex: "94a3b8"))
            }
        }
        .padding(.top, 10)
    }
}

// MARK: - Info Box
struct InfoBox: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 16))
                .foregroundColor(Color(hex: "2563eb"))

            Text(text)
                .font(.system(size: 11))
                .foregroundColor(Color(hex: "1e293b"))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "dbeafe"))
        .cornerRadius(6)
    }
}

// MARK: - Button Styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(configuration.isPressed ? Color(hex: "1d4ed8") : Color(hex: "2563eb"))
            .cornerRadius(8)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color(hex: "1e293b"))
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(configuration.isPressed ? Color(hex: "d1d5db") : Color(hex: "e2e8f0"))
            .cornerRadius(8)
    }
}

struct ProcessButtonStyle: ButtonStyle {
    let enabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(enabled ? (configuration.isPressed ? Color(hex: "1d4ed8") : Color(hex: "2563eb")) : Color(hex: "e2e8f0"))
            .cornerRadius(8)
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
