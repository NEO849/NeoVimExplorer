//
//  FileItem.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 18.05.25.
//

import Foundation

/// Repräsentiert eine Datei oder einen Ordner im Dateisystem.
struct FileItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let path: String
    let isFolder: Bool
    let size: UInt64?                       // Optional bei Ordnern
    let modifiedDate: Date?
}
