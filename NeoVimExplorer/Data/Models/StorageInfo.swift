//
//  StorageInfo.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

/// Einzelne Speicher-Kategorie, z. B. Dokumente, Bilder etc.
struct StorageCategory: Identifiable {
    let id = UUID()
    let name: String
    let usage: Double
}

/// Speicherinformationen zur Anzeige im Speicher bzw. Kreis-Diagramm.
struct StorageInfo {
    let total: UInt64
    let usedSpaceInGb: UInt64
    let category: StorageCategory
}

/// Aufteilung des belegten Speichers in logische Kategorien.
enum StorageCategories: String, CaseIterable {
    case dokumente = "Dokumente"
    case fotos = "Fotos"
    case apps = "Apps"
    case andere = "Andere"
}
