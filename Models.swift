//
//  Models.swift
//  PhoneHasher
//
//  Data models and state management
//

import Foundation

// MARK: - Hash Format Options
struct HashFormatOptions {
    var tenDigit: Bool = false
    var plus91: Bool = false
    var with91: Bool = false
    var truecaller: Bool = false

    var hasSelection: Bool {
        tenDigit || plus91 || with91 || truecaller
    }

    var selectedFormats: [(key: String, name: String)] {
        var formats: [(String, String)] = []
        if tenDigit { formats.append(("10digit", "Hash_for_3P_10digit")) }
        if plus91 { formats.append(("plus91", "Hash_for_3P_with_plus91")) }
        if with91 { formats.append(("91", "Hash_for_3P_with_91")) }
        if truecaller { formats.append(("truecaller", "Hash_for_Truecaller")) }
        return formats
    }
}

// MARK: - Processing State
enum ProcessingState {
    case idle
    case processing(current: Int, total: Int, filename: String, format: String)
    case completed(results: ProcessingResults)
    case error(String)
}

// MARK: - Processing Results
struct ProcessingResults {
    var totalFiles: Int = 0
    var totalRows: Int = 0
    var successfulRows: Int = 0
    var errorRows: Int = 0
    var outputPath: String = ""
}

// MARK: - File Info (for preview table)
struct FileInfo: Identifiable {
    let id = UUID()
    let url: URL
    var rowCount: Int?
    var isCountingRows: Bool = false

    var fileName: String {
        url.lastPathComponent
    }

    var formattedRowCount: String {
        if isCountingRows {
            return "Counting..."
        } else if let count = rowCount {
            return NumberFormatter.localizedString(from: NSNumber(value: count), number: .decimal)
        } else {
            return "Unknown"
        }
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var selectedFiles: [URL] = []
    @Published var fileInfos: [FileInfo] = []
    @Published var hashFormats = HashFormatOptions()
    @Published var customColumnName: String = "phone"
    @Published var outputFolder: URL?
    @Published var processingState: ProcessingState = .idle

    var canProcess: Bool {
        !selectedFiles.isEmpty && hashFormats.hasSelection && outputFolder != nil
    }

    var statusMessage: String {
        if !selectedFiles.isEmpty && !hashFormats.hasSelection && outputFolder == nil {
            return "Select hash format(s) → Select output folder"
        } else if !selectedFiles.isEmpty && !hashFormats.hasSelection {
            return "Select hash format(s)"
        } else if !selectedFiles.isEmpty && outputFolder == nil {
            return "Select output folder"
        } else if selectedFiles.isEmpty {
            return "Select files"
        } else if canProcess {
            return "Ready to process"
        }
        return ""
    }
}
