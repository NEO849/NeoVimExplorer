//
//  SettingsViewModel.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 22.05.25.
//

// Benötigt für UserDefaults
import Foundation
import SwiftUI

/// ViewModel für Benutzereinstellungen, Verteckte Dateien anzeigen, Blurintensität ändern, Layout-Anzeige, Themes und Favoriten.
@Observable
class SettingsViewModel {
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Einstellungen (gespeichert über UserDefaults)
    /// Versteckte Dateien angezeigen? Ruft den Bool-Wert für den Schlüssel "showHiddenFiles" ab (Standartwert ist false).  Den neuen Wert über ´set´ speichern.
    var showHiddenFiles: Bool {
        get { defaults.bool(forKey: "showHiddenFiles") }
        set { defaults.set(newValue, forKey: "showHiddenFiles") }
    }
    
    /// Intensität des Blur-Effekts´im Hintergrund (0.0 bis 1.0).
    var blurEffectIntensity: Double {
        // Ruft den Double-Wert für den Schlüssel "blurEffectIntensity" ab.
        // Wenn Wert 0 (was der Standardwert für Double in UserDefaults ist), wird 0.5 als Standard zurückgegeben.
        get { defaults.double(forKey: "blurEffectIntensity") != 0 ? defaults.double(forKey: "blurEffectIntensity") : 0.5 }
        set { defaults.set(newValue, forKey: "blurEffectIntensity") }
    }
    
    /// Aktuelles Layout (Liste, Grid oder Card)
    var layoutType: LayoutType {
        get { LayoutType(rawValue: defaults.string(forKey: "layoutType") ?? "") ?? .cards }
        set { defaults.set(newValue.rawValue, forKey: "layoutType") }
    }
    
    /// Aktives Farbschema (Theme)
    var theme: Theme {
        get { Theme(rawValue: defaults.string(forKey: "theme") ?? "") ?? .tokyoNight }
        set { defaults.set(newValue.rawValue, forKey: "theme") }
    }
    
    /// Liste aller Favoriten (gespeichert als Array von Pfaden)
    var favorites: [String] {
        get { defaults.stringArray(forKey: "favorites") ?? [] }
        set { defaults.set(newValue, forKey: "favorites") }
    }
    
    // MARK: - Aktionen
    /// Fügt einen Ordner/Dateipfad zu den Favoriten hinzu (Keine Doppelten Favoriten, Pfad wird am Ende dem Array hinzugefügt).
    func addFavorite(_ path: String) {
        guard !favorites.contains(path) else { return }
        favorites.append(path)
    }
    
    /// Entfernt alle Vorkommen des gegebenen Pfades aus dem Favoriten-Array.
    func removeFavorite(_ path: String) {
        favorites.removeAll { $0 == path }
    }
    
    /// Überprüft, ob das Favoriten-Array den gegebenen Pfad enthält.
    func isFavorite(_ path: String) -> Bool {
        favorites.contains(path)
    }
    
    /// Setzt alle Einstellungen auf Standardwerte zurück
    func resetAllSettings() {
        showHiddenFiles = false
        blurEffectIntensity = 0.5
        layoutType = .cards
        theme = .tokyoNight
        favorites = []
    }
}
