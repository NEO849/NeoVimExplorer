//
//  StorageInfo.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

/// Für Auswertungen und das anzeigen der Speicheraufteilung mittels Charts und Kreisdiagramm.
import Foundation

/// Kategorien für den belegten Speicherplatz (Kreisdiagramm).
enum StorageCategoryType: String, Codable, CaseIterable, Identifiable {
    case dokuments = "Dokumente"
    case pictures = "Fotos"
    case apps = "Apps"
    case other = "Andere"

    var id: String { rawValue }
}

/// Einzelne Kategorie mit belegtem Speicherplatz in GB oder Prozent (Für SwiftUI-Charts).
struct StorageCategory: Identifiable, Codable {
    let id: StorageCategoryType
    let usageInGB: Double
    var usagePercent: Double?
    var name: String { id.rawValue }

    init(
        id: StorageCategoryType,
        usageInGB: Double,
        usagePercent: Double? = nil) {
        self.id = id
        self.usageInGB = usageInGB
        self.usagePercent = usagePercent
    }
}

/// Gesamtspeicher-Informationen für die Anzeige und Auswertung und Aufteilung nach Kategorien.
struct StorageInfo: Identifiable, Codable {
    var id = UUID()
    let totalInGB: Double
    let usedInGB: Double
    let categories: [StorageCategory]

    var freeInGB: Double { totalInGB - usedInGB }
}
