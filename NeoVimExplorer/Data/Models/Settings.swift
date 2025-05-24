//
//  Settings.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

// MARK: - Settings (Zentrale App-Einstellungen)
/// Enthält alle globalen UI- und Anzeigeoptionen sowie die Fensterkonfiguration.
struct Settings: Codable {
    var showHiddenFiles: Bool
    var blurEffectIntensity: Double
    var theme: Theme
    var editorLayoutMode: EditorLayoutMode // Globale Fensteraufteilung (1, 2, 4 Fenster)
    var windowConfigs: [WindowConfig] // Einstellungen für jedes einzelne Fenster
    var favorites: [String]
    
    // Standardkonfiguration beim ersten Start
    static let `default` = Settings(
        showHiddenFiles: false,
        blurEffectIntensity: 0.5,
        theme: .tokyoNight,
        editorLayoutMode: .single,
        windowConfigs: [
            WindowConfig(
                contentType: .explorer,
                explorerLayout: .cards)
        ],
        favorites: []
    )
}

// MARK: - Theme (Definiert die verfügbaren UI-Themes)
enum Theme: String, Codable, CaseIterable {
    case tokyoNight = "TokyoNight"
    case gruvbox = "Gruvbox"
    case catppuccin = "Catppuccin"
    case midnight = "Midnight"
}

// MARK: - EditorLayoutMode (Gglobale Fensteraufteilung an (z.B. 1, 2, 4 Fenster)
enum EditorLayoutMode: String, Codable, CaseIterable {
    case single
    case doubleHorizontal
    case doubleVertical
    case quad
}

// MARK: - WindowConfig (Fenster-Inhalt)
// Konfiguriert, was in einem Fenster angezeigt wird (Explorer/Terminal) und ggf. das Layout.
struct WindowConfig: Codable {
    var contentType: ContentType // Explorer oder Terminal
    var explorerLayout: LayoutType? // Layout des Explorers (nur relevant, wenn Explorer gewählt)
}

// MARK: - WindowContentType (Fenster-Typ)
// Bestimmt, ob ein Fenster den Explorer oder das Terminal zeigt.
enum ContentType: String, Codable, CaseIterable {
    case explorer
    case terminal
}

// MARK: - LayoutType (Explorer-Layout)
// Definiert die möglichen Layouts für den Explorer (Liste, Grid, Cards).
enum LayoutType: String, Codable, CaseIterable {
    case list, grid, cards
}
