//
//  TerminalCommand.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

///  Repräsentiert eine einzelne Terminal-Eingabe samt Ausgabe.
struct TerminalCommand: Identifiable {
    let id = UUID()
    let input: String
    let output: String
    let timestamp: Date
}
