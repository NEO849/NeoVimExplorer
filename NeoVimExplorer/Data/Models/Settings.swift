//
//  Settings.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

/// Modell für benutzerspezifische UI-Optionen (Theme, Layout, etc.)
struct Settings: Codable {
    var showHiddenFiles: Bool
    var blurEffectIntensity: Double       // Intensität des Blur-Effekts (0.0–1.0)
    var layoutType: LayoutType            // Aktuelles Layout (Liste, Grid, Cards)
    var theme: Theme                      // Ausgewähltes Theme für Hintergrund & Farben
}

/// Varianten für die Dateiansicht
enum LayoutType: String, Codable, CaseIterable {
    case list, grid, cards
}

/// Auswahl an Farb-Themes (wie Neovim – jeweils mit zugeordnetem Hintergrund)
enum Theme: String, Codable, CaseIterable {
    case tokyoNight = "TokyoNight"
    case gruvbox = "Gruvbox"
    case catppuccin = "Catppuccin"
}
