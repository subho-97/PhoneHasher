//
//  HashProcessor.swift
//  PhoneHasher
//
//  Phone number hashing and CSV processing - OPTIMIZED for large files
//

import Foundation
import CryptoKit

class HashProcessor {

    // MARK: - Hash Phone Number
    static func hashPhone(_ phone: String, format: String) -> String {
        // Clean the phone number
        let cleanedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let digits = cleanedPhone.filter { $0.isNumber }

        // Validate
        guard digits.count >= 10 && digits.count <= 12 else {
            return "ERROR: Invalid format: \(phone)"
        }

        // Get last 10 digits
        let last10 = String(digits.suffix(10))

        // Format based on type
        let numberToHash: String
        switch format {
        case "10digit":
            numberToHash = last10
        case "plus91":
            numberToHash = "+91\(last10)"
        case "91", "truecaller":
            numberToHash = "91\(last10)"
        default:
            numberToHash = last10
        }

        // SHA-256 hash
        let data = Data(numberToHash.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }

    // MARK: - Count Rows in File (Fast)
    static func countRows(in fileURL: URL) -> Int {
        do {
            let fileHandle = try FileHandle(forReadingFrom: fileURL)
            defer { try? fileHandle.close() }

            var count = 0
            let chunkSize = 1024 * 1024 // 1MB chunks

            while autoreleasepool(invoking: {
                let data = fileHandle.readData(ofLength: chunkSize)
                if data.isEmpty { return false }

                count += data.filter { $0 == 10 }.count // Count newlines (ASCII 10)
                return true
            }) {}

            return count
        } catch {
            return 0
        }
    }

    // MARK: - Process Files
    static func processFiles(
        files: [URL],
        formats: HashFormatOptions,
        columnName: String,
        outputFolder: URL,
        progressCallback: @escaping (Int, Int, String, String) -> Void
    ) async -> ProcessingResults {

        var results = ProcessingResults()
        let selectedFormats = formats.selectedFormats
        let totalOperations = files.count * selectedFormats.count
        var currentOperation = 0

        for fileURL in files {
            let fileName = fileURL.deletingPathExtension().lastPathComponent

            for (formatKey, folderName) in selectedFormats {
                currentOperation += 1

                // Update progress
                await MainActor.run {
                    progressCallback(currentOperation, totalOperations, fileURL.lastPathComponent, folderName)
                }

                // Process file
                do {
                    let fileResults = try await processFileFast(
                        fileURL: fileURL,
                        fileName: fileName,
                        formatKey: formatKey,
                        folderName: folderName,
                        columnName: columnName,
                        outputFolder: outputFolder
                    )

                    results.totalFiles += 1
                    results.totalRows += fileResults.total
                    results.successfulRows += fileResults.success
                    results.errorRows += fileResults.errors
                    results.outputPath = outputFolder.path

                } catch {
                    print("Error processing file: \(error.localizedDescription)")
                    results.errorRows += 1
                }
            }
        }

        return results
    }

    // MARK: - Process Single File (STREAMING - Fast for large files)
    private static func processFileFast(
        fileURL: URL,
        fileName: String,
        formatKey: String,
        folderName: String,
        columnName: String,
        outputFolder: URL
    ) async throws -> (total: Int, success: Int, errors: Int) {

        // Create output directory
        let outputDir = outputFolder.appendingPathComponent(folderName)
        try FileManager.default.createDirectory(at: outputDir, withIntermediateDirectories: true)

        // Create output file
        let outputFile = outputDir.appendingPathComponent("\(fileName)_hashed.csv")
        FileManager.default.createFile(atPath: outputFile.path, contents: nil)

        guard let outputHandle = FileHandle(forWritingAtPath: outputFile.path) else {
            throw NSError(domain: "HashProcessor", code: 2, userInfo: [NSLocalizedDescriptionKey: "Cannot create output file"])
        }

        defer { try? outputHandle.close() }

        // Open input file for streaming
        guard let inputHandle = FileHandle(forReadingFrom: fileURL) else {
            throw NSError(domain: "HashProcessor", code: 3, userInfo: [NSLocalizedDescriptionKey: "Cannot open input file"])
        }

        defer { try? inputHandle.close() }

        var successCount = 0
        var errorCount = 0
        var totalCount = 0
        var isFirstLine = true
        var buffer = Data()
        let chunkSize = 1024 * 1024 // 1MB chunks for reading
        let newline = UInt8(10) // ASCII newline

        // Write header if needed
        if formatKey != "truecaller" {
            let headerData = "\(columnName)\n".data(using: .utf8)!
            outputHandle.write(headerData)
        }

        // Process file in chunks
        while autoreleasepool(invoking: {
            let chunk = inputHandle.readData(ofLength: chunkSize)
            if chunk.isEmpty { return false }

            buffer.append(chunk)

            // Process complete lines in buffer
            while let newlineIndex = buffer.firstIndex(of: newline) {
                let lineData = buffer[..<newlineIndex]
                buffer = buffer[(newlineIndex + 1)...]

                guard let line = String(data: lineData, encoding: .utf8) else { continue }
                let trimmedLine = line.trimmingCharacters(in: .whitespaces)

                if trimmedLine.isEmpty { continue }

                // Check if first line is header
                if isFirstLine {
                    isFirstLine = false
                    let firstColumn = trimmedLine.components(separatedBy: ",")[0].trimmingCharacters(in: .whitespaces)
                    let digitsInFirst = firstColumn.filter { $0.isNumber }

                    // Skip if header (less than 10 digits)
                    if digitsInFirst.count < 10 {
                        continue
                    }
                }

                // Extract phone number from first column
                let columns = trimmedLine.components(separatedBy: ",")
                guard !columns.isEmpty else { continue }

                let phoneNumber = columns[0].trimmingCharacters(in: .whitespaces)
                let hashed = hashPhone(phoneNumber, format: formatKey)

                if hashed.starts(with: "ERROR:") {
                    errorCount += 1
                } else {
                    successCount += 1
                }

                totalCount += 1

                // Write hashed line immediately (streaming!)
                let hashedLine = hashed + "\n"
                if let hashedData = hashedLine.data(using: .utf8) {
                    outputHandle.write(hashedData)
                }
            }

            return true
        }) {}

        // Process any remaining data in buffer
        if !buffer.isEmpty {
            if let line = String(data: buffer, encoding: .utf8) {
                let trimmedLine = line.trimmingCharacters(in: .whitespaces)

                if !trimmedLine.isEmpty {
                    let columns = trimmedLine.components(separatedBy: ",")
                    if !columns.isEmpty {
                        let phoneNumber = columns[0].trimmingCharacters(in: .whitespaces)
                        let hashed = hashPhone(phoneNumber, format: formatKey)

                        if hashed.starts(with: "ERROR:") {
                            errorCount += 1
                        } else {
                            successCount += 1
                        }

                        totalCount += 1

                        if let hashedData = hashed.data(using: .utf8) {
                            outputHandle.write(hashedData)
                        }
                    }
                }
            }
        }

        return (total: totalCount, success: successCount, errors: errorCount)
    }
}
