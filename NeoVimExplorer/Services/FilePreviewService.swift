//
//  FilePreviewService.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//
import Foundation
import SwiftUI
import QuickLook

/// Service zum Anzeigen von Datei-Vorschauen.
final class FilePreviewService {
    
    private var previewController: QLPreviewController?
    private var currentDataSource: QLDataSource?
    
    /// Öffnet eine Datei zur Vorschau (QuickLook)
    func preview(fileAt url: URL) {
        let controller = QLPreviewController()
        // Instanz der Benutzerdefinierten Datenquelle, teilt dem Controller mit, welche Datei angezeigt werden soll.
        let dataSource = QLDataSource(fileURL: url)
        
        // Hält eine starke Referenz auf die Datenquelle (`dataSource`), ist notwendig, da die 'dataSource'-Eigenschaft des QLPreviewControllers 'weak' ist.
        self.currentDataSource = dataSource
        
        // Weist die Datenquelle dem Controller zu.
        controller.dataSource = self.currentDataSource
        
        // Hält eine starke Referenz auf den Controller selbst (`previewController`), ist notwendig, damit der Controller nicht verschwindet, bevor er angezeigt wird.
        self.previewController = controller
        
        // MARK: - Präsentation des QLPreviewControllers
        // Versucht, die aktuelle UIWindowScene und das zugehörige Fenster zu finden.
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              var topViewController = window.rootViewController else {
            print("⚠️ Fehler: Konnte keinen Root-ViewController zum Präsentieren der Vorschau finden.")
            return
        }
        
        // Rekursiv den obersten sichtbaren ViewController finden, ist wichtig, falls der Root-ViewController ein Container-Controller ist (z.B. UINavigationController, UITabBarController)
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        
        // Präsentiert den QLPreviewController vom obersten sichtbaren ViewController aus.
        // `animated: true` sorgt für eine sanfte Animation beim Erscheinen der Vorschau.
        // `completion: nil` keine Aktion wird ausgeführt wird, nachdem die Präsentation abgeschlossen ist.
        topViewController.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Private Hilfsklasse für die QuickLook-Datenquelle
    private class QLDataSource: NSObject, QLPreviewControllerDataSource {
        let fileURL: URL
        
        init(fileURL: URL) {
            self.fileURL = fileURL
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            fileURL as QLPreviewItem
        }
    }
}


