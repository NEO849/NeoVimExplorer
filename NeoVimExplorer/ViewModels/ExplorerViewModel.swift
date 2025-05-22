//
//  ExplorerViewModel.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import SwiftUI

/// Lädt Informationen mittels Singelton-FileRepo. Kümmerst sich um Logik für Dateiübersicht und Speicheranalyse.
@Observable
class ExplorerViewModel {
    
    private let repository = FileRepository.shared
    private let themeService = ThemeService()
    var files: [FileItem] = []                            // Alle geladenen Dateien
    var storageInfo: [StorageInfo] = []                   // Aktuelle Speicherinformationen
    var searchQuery: String = ""                          // Text aus der Suchleiste

    // MARK: - Fuzzy Suche, Gefilterte Liste von Dateien basierend auf dem Suchtext.
    var filteredFiles: [FileItem] {
        guard !searchQuery.isEmpty else { return files }
        return files.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
    }

    // MARK: - Informationen Laden

    /// Lädt alle Dateien aus dem Dateisystem (z. B. aus dem Dokumente-Ordner).
    func loadFiles() {
        self.files = repository.fetchFiles()
    }

    /// Lädt die aktuellen Speicherinformationen.
    func loadStorageInfo() {
        self.storageInfo = repository.fetchStorageInfo()
    }

    /// Gibt den aktuellen Hintergrundbild-Namen zurück (wird von View verwendet)
    func backgroundImageName(for theme: Theme) -> String {
        return themeService.backgroundImageName(for: theme)
    }

    /// Gibt eine Akzentfarbe für das aktive Theme zurück (z. B. für Icons, Texte)
    func accentColor(for theme: Theme) -> Color {
        return themeService.accentColor(for: theme)
    }
}
