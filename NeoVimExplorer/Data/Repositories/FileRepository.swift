//
//  FileRepository.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation
import UIKit

/// Dient als zentrale Datenquelle (Source of Truth) für Dateien & Speicherinformationen.
final class FileRepository {
    
    /// Umschalter zwischen Mock- und echten Daten (kann global verändert werden)
    static var useMockData: Bool = true
    
    private let fileManager = FileManager.default
    
    // MARK: - Dateien laden (Mock-Datei oder vom echten Dateisystem)
    func loadFiles() -> [FileItem] {
        if FileRepository.useMockData {
            return loadMockFiles()
        } else {
            return loadRealFiles(at: fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!)
        }
    }
    
    /// Lädt Dateien aus `MockFiles.json`
    private func loadMockFiles() -> [FileItem] {
        guard let url = Bundle.main.url(forResource: "MockFiles", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("⚠️ Konnte MockFiles.json nicht laden")
            return []
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            return try decoder.decode([FileItem].self, from: data)
        } catch {
            print("⚠️ Fehler beim Parsen: \(error)")
            return []
        }
    }
    
    /// Lädt reale Dateien (vereinfachte Version für Startordner)
    private func loadRealFiles(at url: URL) -> [FileItem] {
        do {
            let fileURLs = try fileManager.contentsOfDirectory(
                at: url,
                includingPropertiesForKeys: [.fileSizeKey, .contentModificationDateKey],
                options: [.skipsHiddenFiles]
            )
            return fileURLs.compactMap { itemURL in
                guard let attributes = try? fileManager.attributesOfItem(atPath: itemURL.path) else {
                    print("⚠️ Konnte Attribute für \(itemURL.lastPathComponent) nicht laden.")
                    return nil
                }
                let isDirectory = (attributes[.type] as? FileAttributeType) == .typeDirectory
                let fileType: FileType = isDirectory ? .folder : .file
                let size = (attributes[.size] as? Int) ?? 0
                let date = (attributes[.modificationDate] as? Date) ?? Date()
                let children: [FileItem]? = isDirectory ? loadRealFiles(at: itemURL) : nil
                return FileItem(
                    id: UUID(),
                    name: itemURL.lastPathComponent,
                    type: fileType,
                    size: size,
                    dateModified: date,
                    isFavorite: false,
                    children: children
                )
            }
        } catch {
            print("⚠️ Fehler beim Lesen des Verzeichnisses \(url.path): \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Speicher Infos je nach Modus
    func loadStorageInfo() -> StorageInfo {
        if FileRepository.useMockData {
            return loadMockStorage()
        } else {
            return loadRealStorage()
        }
    }
    
    /// Lädt Speicher-Infos aus `MockStorage.json`.
    private func loadMockStorage() -> StorageInfo {
        guard let url = Bundle.main.url(forResource: "MockStorage", withExtension: "json", subdirectory: "Data/MockFiles"),
              let data = try? Data(contentsOf: url) else {
            print("⚠️ Konnte MockStorage.json nicht im Pfad 'Data/MockFiles' finden oder laden.")
            return .init(totalInGB: 0, usedInGB: 0, categories: [])
        }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(StorageInfo.self, from: data)
        } catch {
            print("⚠️ Fehler beim Parsen von MockStorage.json: \(error.localizedDescription)")
            // Gib eine sinnvolle Standard-StorageInfo zurück
            return .init(totalInGB: 0, usedInGB: 0, categories: [])
        }
    }
    
    /// Liest echten Gerätespeicher.
    private func loadRealStorage() -> StorageInfo {
        let total = UIDevice.current.systemCapacity
        let free = UIDevice.current.systemFreeSize
        let used = total - free
        
        let totalGB = Double(total) / 1_000_000_000
        let usedGB = Double(used) / 1_000_000_000
        
        // Berechnung der Prozente für jede Kategorie
        let totalEstimatedUsed = usedGB // Hier nur usedGB als Basis, da es Schätzungen sind
        let appsUsage = totalEstimatedUsed * 0.4
        let picturesUsage = totalEstimatedUsed * 0.3
        let documentsUsage = totalEstimatedUsed * 0.2
        let otherUsage = totalEstimatedUsed * 0.1
        
        let categories: [StorageCategory] = [
            StorageCategory(id: .apps, usageInGB: appsUsage, usagePercent: totalEstimatedUsed > 0 ? appsUsage / totalEstimatedUsed : 0),
            StorageCategory(id: .pictures, usageInGB: picturesUsage, usagePercent: totalEstimatedUsed > 0 ? picturesUsage / totalEstimatedUsed : 0),
            StorageCategory(id: .dokuments, usageInGB: documentsUsage, usagePercent: totalEstimatedUsed > 0 ? documentsUsage / totalEstimatedUsed : 0),
            StorageCategory(id: .other, usageInGB: otherUsage, usagePercent: totalEstimatedUsed > 0 ? otherUsage / totalEstimatedUsed : 0)
        ]
        
        return StorageInfo(
            totalInGB: totalGB,
            usedInGB: usedGB,
            categories: categories
        )
    }
}

// MARK: - Erweiterungen für Speicherinformationen auf UIDevice.
// Diese bleiben unverändert, da sie systemweite Informationen liefern.

extension UIDevice {
    /// Gibt die gesamte Speicherkapazität des Geräts in Bytes zurück.
    var systemCapacity: Int64 {
        guard let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [.volumeTotalCapacityKey]).volumeTotalCapacity else {
            return 0
        }
        return Int64(space)
    }
    
    /// Gibt den verfügbaren freien Speicherplatz auf dem Gerät in Bytes zurück.
    var systemFreeSize: Int64 {
        guard let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [.volumeAvailableCapacityKey]).volumeAvailableCapacity else {
            return 0
        }
        return Int64(space)
    }
}
