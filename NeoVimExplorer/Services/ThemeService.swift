//
//  ThemeService.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import SwiftUI

/// Verwalten von Themes und zugehörigen Hintergrundbildern.
class ThemeService {
    
    /// Liefert den Namen des Hintergrundbildes basierend auf dem gewählten Theme.
    func backgroundImageName(for theme: Theme) -> String {
        switch theme {
        case .tokyoNight: return "TokyoNight"
        case .gruvbox: return "Gruvbox"
        case .catppuccin: return "Catppuccin"
        }
    }

    /// Passende Akzentfarbe pro Theme
    func accentColor(for theme: Theme) -> Color {
        switch theme {
        case .tokyoNight: return .purple
        case .gruvbox: return .orange
        case .catppuccin: return .mint
        }
    }
}
