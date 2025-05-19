//
//  FileRepository.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation
import UIKit

/// Laden von Dateien aus dem Dateisystem und die Berechnung des Speicherplatzes.
class FileRepository {
    /// Singleton-Instanz,  nur eine Instanz dieser Klasse im gesamten Programm.
    static let shared = FileRepository()

    /// FileManager ermöglicht die Interaktion mit dem Dateisystem.
    private let fileManager = FileManager.default

    /// Lädt alle Dateien und Ordner aus dem Dokumentenverzeichnis des Benutzers.
    ///
    /// - Returns: Ein Array von `FileItem`-Objekten, die Informationen über jede gefundene Datei oder jeden Ordner enthalten.
    func fetchFiles() -> [FileItem] {
        // Ermittelt die URL des Dokumentenverzeichnisses des Benutzers.
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("⚠️ Fehler: Dokumentenverzeichnis nicht gefunden.")
            return []
        }

        do {
            // Liest den Inhalt des Dokumentenverzeichnisses und fragt nach den Eigenschaften Dateigröße und Änderungsdatum.
            let fileURLs = try fileManager.contentsOfDirectory(
                at: documentsURL,
                includingPropertiesForKeys: [.fileSizeKey, .contentModificationDateKey],
                options: [.skipsHiddenFiles] // Überspringt versteckte Dateien und Ordner (beginnend mit einem Punkt).
            )

            // Wandelt die Array von Datei-URLs in ein Array von `FileItem`-Objekten um. Versucht, die Eigenschaften abzurufen.
            return fileURLs.map { url in
                let attributes = try? fileManager.attributesOfItem(atPath: url.path)
                // Erstellt ein `FileItem`-Objekt mit den extrahierten Informationen.
                return FileItem(
                    id: UUID(),
                    name: url.lastPathComponent,
                    path: url.path,
                    isFolder: (attributes?[.type] as? FileAttributeType) == .typeDirectory,
                    sizeKb: (attributes?[.size] as? Int).map { $0 / 1024 }, // Ruft die Größe in Bytes ab und konvertiert sie in Kilobyte.
                    modifiedDate: attributes?[.modificationDate] as? Date
                )
            }
        } catch {
            print("⚠️ Fehler beim Laden der Dateien: \(error.localizedDescription)")
            return []
        }
    }

    /// Liefert eine vereinfachte Analyse des belegten Speicherplatzes auf dem Gerät.
    ///
    /// - Returns: Ein Array von `StorageInfo`-Objekten, die Kategorien und den ungefähren belegten Speicherplatz in Gigabyte darstellen.
    func fetchStorageInfo() -> [StorageInfo] {
        // Versucht, Speicherkapazität und den verfügbaren freien Speicherplatzdes Geräts abzurufen.
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
            .init(category: .fotos, usedSpaceInGb: Double(used) * 0.3 / 1_000_000_000), // Schätzt den Speicherverbrauch von Fotos.
            .init(category: .dokumente, usedSpaceInGb: Double(used) * 0.2 / 1_000_000_000), // Schätzt den Speicherverbrauch von Dokumenten.
            .init(category: .andere, usedSpaceInGb: Double(used) * 0.1 / 1_000_000_000) // Schätzt den Speicherverbrauch für andere Dateitypen.
        ]
    }
}

// MARK: - Erweiterungen für Speicherinformationen auf UIDevice (optional, für bessere Lesbarkeit)

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
