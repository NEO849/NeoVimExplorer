//
//  TerminalViewModel.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 22.05.25.
//

import Foundation

/// Greift auf den TerminalService zu und stellt eine zentrale Logikschicht für die TerminalView dar. Simuliert ein Terminal wie bei Neovim – mit Eingabeverlauf, Timestamp und Befehlsausgabe.
@Observable
class TerminalViewModel {
    
    // MARK: - Interner Service
    private let terminalService = TerminalService()   // Führt die Befehle aus
    
    // MARK: - Eingabe & Verlauf
    var commandInput: String = ""                     // Aktuell eingegebener Text
    var commandHistory: [TerminalCommand] = []        // Liste aller bisherigen Eingaben + Ausgaben
    
    // MARK: - Öffentliche Methoden
    /// Führt den aktuellen Befehl aus und speichert ihn im Verlauf
    func executeCurrentCommand() {
        // Whitespace entfernen
        let trimmedCommand = commandInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedCommand.isEmpty else { return }

        // Ausgabe vom Service abfragen und Neuen Verlaufseintrag erzeugen, Historie hinzufügen, Eingabefeld leeren.
        let output = terminalService.execute(command: trimmedCommand)
        let newCommand = TerminalCommand(
            input: trimmedCommand,
            output: output,
            timestamp: Date()
        )
        commandHistory.append(newCommand)
        commandInput = ""
    }

    /// Löscht den gesamten Verlauf
    func clearHistory() {
        commandHistory.removeAll()
    }
}
