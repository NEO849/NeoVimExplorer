//
//  TerminalService.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

/// Simuliert einfache CLI-Befehle wie in einem Neovim-Terminal.
class TerminalService {
    
    /// Führt einen Befehl aus und gibt die Antwort als Text zurück
    func execute(command: String) -> String {
        switch command {
        case "la": return listDirectory()
        case "pwd": return currentDirectory()
        case "date": return currentDate()
        case "help": return availableCommands()
        default:
            return "❌ Befehl nicht erkannt. Gib 'help' ein."
        }
    }

    private func listDirectory() -> String {
        let fm = FileManager.default
        let url = fm.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            let items = try fm.contentsOfDirectory(atPath: url.path)
            return items.joined(separator: "\n")
        } catch {
            return "⚠️ Fehler: \(error.localizedDescription)"
        }
    }

    private func currentDirectory() -> String {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.path
    }

    private func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }

    private func availableCommands() -> String {
        return """
        Unterstützte Befehle:
        - la      → listet Dateien im Dokumentenordner
        - pwd     → aktueller Pfad
        - date    → aktuelles Datum
        - help    → zeigt diese Hilfe
        """
    }
}
