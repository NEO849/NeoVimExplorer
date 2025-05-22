//
//  FileRepository.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation
import UIKit

/// Zentrale Datenquelle. Laden von Dateien aus dem Dateisystem und die Berechnung des Speicherplatzes.
class FileRepository {
    
    static let shared = FileRepository() // Singleton-Instanz
    private let fileManager = FileManager.default // Interaktion mit dem Dateisystem

    /// Lädt alle Dateien und Ordner aus dem Dokumentenverzeichnis des Benutzers.
    /// - Returns: Ein Array von `FileItem`-Objekten, die Informationen über jede gefundene Datei oder jeden Ordner enthalten.
    func fetchFiles() -> [FileItem] {
        // Ermittelt die URL des Dokumentenverzeichnisses des Benutzers.
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("⚠️ Fehler: Dokumentenverzeichnis nicht gefunden.")
            return []
        }

        do {
            // Liest den Inhalt des Dokumentenverzeichnisses. Eigenschaften - Dateigröße und Änderungsdatum ermitteln.
            let fileURLs = try fileManager.contentsOfDirectory(
                at: documentsURL,
                includingPropertiesForKeys: [.fileSizeKey, .contentModificationDateKey],
                options: [.skipsHiddenFiles] // Überspringt versteckte Dateien und Ordner (beginnend mit einem Punkt).
            )

            // Wandelt die Array von Datei-URLs in ein Array von `FileItem`-Objekten um. Versucht, die Eigenschaften abzurufen.
            return fileURLs.map { url in
                let attributes = try? fileManager.attributesOfItem(atPath: url.path)
                // `FileItem`-Objekt erstellen, Informationen extrahieren.
                return FileItem(
                    id: UUID(),
                    name: url.lastPathComponent,
                    path: url.path,
                    isFolder: (attributes?[.type] as? FileAttributeType) == .typeDirectory,
                    sizeKb: (attributes?[.size] as? Int).map { $0 / 1024 }, // Bytes größe abrufen und in Kilobyte konvertieren.
                    modifiedDate: attributes?[.modificationDate] as? Date
                )
            }
        } catch {
            print("⚠️ Fehler beim Laden der Dateien: \(error.localizedDescription)")
            return []
        }
    }

    /// Liefert eine vereinfachte Analyse des belegten Speicherplatzes auf dem Gerät.
    /// - Returns: Ein Array von `StorageInfo`-Objekten, die Kategorien und den ungefähren belegten Speicherplatz in Gigabyte darstellen.
    func fetchStorageInfo() -> [StorageInfo] {
        // Speicherkapazität und den verfügbaren freien Speicherplatzes abzurufen.
        let totalSpace = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [.volumeTotalCapacityKey]).volumeTotalCapacity
        let freeSpace = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [.volumeAvailableCapacityKey]).volumeAvailableCapacity

        // Falls die Werte nicht abgerufen werden können, wird 0 verwendet.
        let total = totalSpace ?? 0
        let free = freeSpace ?? 0
        let used = total - free

        // Gibt ein Array von `StorageInfo`-Objekten mit vereinfachten Kategorien und Schätzungen des belegten Speicherplatzes zurück.
        // Die Prozentwerte (0.4, 0.3, 0.2, 0.1) sind Schätzungen und können je nach Gerät und Nutzung variieren.
        return [
            .init(category: .apps, usedSpaceInGb: Double(used) * 0.4 / 1_000_000_000), // Schätzt den Speicherverbrauch von Apps.
            .init(category: .fotos, usedSpaceInGb: Double(used) * 0.3 / 1_000_000_000), // Fotos.
            .init(category: .dokumente, usedSpaceInGb: Double(used) * 0.2 / 1_000_000_000), // Dokumenten.
            .init(category: .andere, usedSpaceInGb: Double(used) * 0.1 / 1_000_000_000) // Dateitypen.
        ]
    }
}

// MARK: - Erweiterungen für Speicherinformationen auf UIDevice.

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
