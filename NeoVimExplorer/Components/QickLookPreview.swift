//
//  QickLookPreview.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 22.05.25.
//

import SwiftUI
import QuickLook

/// SwiftUI-kompatibler QuickLook-Wrapper, bettet einen QLPreviewController in eine SwiftUI-Hierarchie ein.
/// Stellt eine Datei-Vorschau zur Verfügung, ähnlich wie „Quick Look“ im nativen iOS/macOS Stil.
struct QuickLookPreview: UIViewControllerRepresentable {
    
    let fileURL: URL // Url die angezeigt wird

    /// Erstellt den UIKit QLPreviewController und bindet den Coordinator als Datenquelle
    /// - Parameter context: Der Kontext, der Informationen über die Umgebung bereitstellt.
    /// - Returns: Eine konfigurierte Instanz von QLPreviewController.
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()         // Initialisierung der Vorschau-Komponente
        controller.dataSource = context.coordinator    // Setzen der Datenquelle (Coordinator)
        return controller
    }

    /// Wird bei Änderungen erneut aufgerufen. Keine Aktualisierung des Controllers selbst notwendig, URL wird beim Erstellen bereits festgelegt.
    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {}

    /// Erstellt den Coordinator, der als Datenquelle dient
    func makeCoordinator() -> Coordinator {
        Coordinator(fileURL: fileURL)
    }

    /// Der Coordinator kümmert sich um die Datenquelle des QLPreviewControllers (Hilfsklasse die das QLPreviewControllerDataSource-Protokoll implementiert).
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let fileURL: URL

        init(fileURL: URL) {
            self.fileURL = fileURL
        }

        /// Gibt die Anzahl der zu zeigenden Objekte zurück (Immer 1, da nur eine einzelne Datei angezeigt werden soll).
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        /// Gibt das Objekt zurück, das angezeigt werden soll (unsere Datei)
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            // Die URL selbst kann als QLPreviewItem verwendet werden, da URL das Protokoll implementiert.
            return fileURL as QLPreviewItem
        }
    }
}
