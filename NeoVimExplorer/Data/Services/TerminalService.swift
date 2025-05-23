//
//  TerminalService.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

/// Simuliert einfache CLI-Befehle wie in einem Neovim-Terminal.
class TerminalService {
    
    /// Führt einen Pseudo-Terminalbefehl aus und liefert die Ausgabe.
    func execute(command: String) -> String {
        switch command.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
        case "ls":
            return mockDirectoryListing()
        case "pwd":
            return FileManager.default.currentDirectoryPath
        case "date":
            return DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
        case "help":
            return """
            Unterstützte Befehle:
            - ls      : Zeige Dateiliste
            - pwd     : Aktuelles Verzeichnis
            - date    : Aktuelles Datum/Zeit
            - help    : Diese Hilfe anzeigen
            """
        default:
            return "❌ Unbekannter Befehl: \(command)"
        }
    }

    /// Beispielausgabe für "ls"
    private func mockDirectoryListing() -> String {
        let exampleFiles = ["Dokumente", "Projekt.swift", "NeoExplorer.db", "README.md"]
        return exampleFiles.joined(separator: "\n")
    }
}
