//
//  ThemeService.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import SwiftUI

// MARK: - Zugriff erfolgt über das SettingsViewModel.
/// Liefert Farben und Hintergrundbilder basierend auf dem aktuellen Theme.
struct ThemeService {

    /// Gibt den Namen des passenden Hintergrundbildes im Asset-Katalog zurück.
    static func backgroundImageName(for theme: Theme) -> String {
        switch theme {
        case .tokyoNight: return "TokyoNight"
        case .gruvbox:    return "Gruvbox"
        case .catppuccin: return "Catppuccin"
        case .midnight:   return "Midnight"
        }
    }

    /// Haupttextfarbe passend zum Theme.
    static func textColor(for theme: Theme) -> Color {
        switch theme {
        case .tokyoNight: return Color("TokyoNightPrimary")
        case .gruvbox:    return Color("GruvboxPrimary")
        case .catppuccin: return Color("CatppuccinPrimary")
        case .midnight:   return Color("MidnightPrimary")
        }
    }

    /// Akzentfarbe (Buttons etc.) für das aktuelle Theme..
    static func accentColor(for theme: Theme) -> Color {
        switch theme {
        case .tokyoNight: return Color("TokyoNightAccent")
        case .gruvbox:    return Color("GruvboxAccent")
        case .catppuccin: return Color("CatppuccinAccent")
        case .midnight:   return Color("MidnightAccent")
        }
    }

    /// Passende Divider-Farbe.
    static func dividerColor(for theme: Theme) -> Color {
        switch theme {
        case .tokyoNight: return Color("TokyoNightDivider")
        case .gruvbox:    return Color("GruvboxDivider")
        case .catppuccin: return Color("CatppuccinDivider")
        case .midnight:   return Color("MidnightDivider")
        }
    }
}
