//
//  TerminalCommand.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

///  Speichert einzelne Terminaleingaben mit Ausgabe.
struct TerminalCommand: Identifiable, Codable {
    var id = UUID()
    let input: String
    let output: String
    let timestamp: Date
}
