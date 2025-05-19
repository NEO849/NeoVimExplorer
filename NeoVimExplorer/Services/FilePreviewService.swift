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
class FilePreviewService {
    /// Öffnet eine Datei zur Vorschau (QuickLook)
    func preview(fileAt url: URL) {
        let controller = QLPreviewController()
        controller.dataSource = QLDataSource(fileURL: url)

        // IHier eine ViewController-Präsentation einbauen.
        // In SwiftUI -> über UIViewControllerRepresentable
    }

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


