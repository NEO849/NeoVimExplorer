//
//  StorageInfo.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

/// Struktur für Speicherinformationen zur Anzeige im Speicher-Diagramm.
struct StorageInfo: Identifiable {
    let id = UUID()
    let category: StorageCategory
    let usedSpaceGb: Double                 // Belegter Speicher in GB
}

/// Aufteilung des belegten Speichers in logische Kategorien.
enum StorageCategory: String, CaseIterable {
    case dokumente = "Dokumente"
    case fotos = "Fotos"
    case apps = "Apps"
    case andere = "Andere"
}
