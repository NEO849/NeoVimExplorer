//
//  FileItem.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 18.05.25.
//

import Foundation

/// Enum zur Typbestimmung: Datei oder Ordner
enum FileType: String, Codable, CaseIterable {
    case file      // Normale Datei
    case folder    // Ordner
}

/// Repräsentiert eine Datei oder einen Ordner mit optionalen Kindern.
struct FileItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var type: FileType
    var size: Int                      // Größe in Byte (0 bei Ordnern)
    var dateModified: Date
    var isFavorite: Bool
    var children: [FileItem]?         // Optional: Unterelemente bei Ordnern
    
    /// Initialisierer für neue Dateieinträge
    init(id: UUID = UUID(),
         name: String,
         type: FileType,
         size: Int = 0,
         dateModified: Date = Date(),
         isFavorite: Bool = false,
         children: [FileItem]? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.size = size
        self.dateModified = dateModified
        self.isFavorite = isFavorite
        self.children = children
    }
}
