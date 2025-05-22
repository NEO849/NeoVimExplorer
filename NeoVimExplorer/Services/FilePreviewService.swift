//
//  FilePreviewService.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//
import Foundation
import SwiftUI

/// Service zum Anzeigen von Datei-Vorschauen.
class FilePreviewService: ObservableObject {

    /// Die URL der Datei, die aktuell in der Vorschau angezeigt werden soll.
    /// Wenn dieser Wert auf eine URL gesetzt wird, signalisiert dies einer View,
    /// dass eine Vorschau geöffnet werden soll. Wenn er auf `nil` gesetzt wird,
    /// sollte die Vorschau geschlossen werden.
    @Published var fileToPreview: URL?

    /// Singleton-Instanz,
    static let shared = FilePreviewService()

    /// Privater Initialisierer, um die Erstellung weiterer Instanzen außerhalb des Singletons zu verhindern.
    private init() {}

    /// Fordert an, dass eine Datei in der Vorschau angezeigt wird.
    /// - Parameter url: Die URL der Datei, die angezeigt werden soll.
    func showPreview(for url: URL) {
        // Setzt die 'fileToPreview'-Eigenschaft auf die gegebene URL.
        // Dies löst ein Update bei allen Views aus, die diesen Service beobachten.
        self.fileToPreview = url
    }

    /// Schließt die aktuell angezeigte Dateivorschau. Setzt 'fileToPreview' auf nil, was die View veranlasst, die Vorschau zu schließen.
    func dismissPreview() {
        self.fileToPreview = nil
    }
}
