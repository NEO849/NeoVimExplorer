//
//  ExplorerViewModel.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 19.05.25.
//

import Foundation

/// Lädt Informationen mittels Singelton-FileRepo. Kümmerst sich um Logik für Dateiübersicht und Speicheranalyse.
@Observable
class ExplorerViewModel {
    
    // MARK: - Abhaengigkeiten, Zugriff auf Dateien & Speicher
    private let fileRepository = FileRepository()

    // MARK: - Zustand
    var files: [FileItem] = []
    var storageInfo: StorageInfo?
    var selectedFile: FileItem? = nil

    // MARK: - Initialisierung
    init() {
        loadData()
    }

    // MARK: - Dateien und Speicherinfos anhand des Modus
    func loadData() {
        files = fileRepository.loadFiles()
        storageInfo = fileRepository.loadStorageInfo()         
    }

    /// Aktualisiert die aktuell ausgewählte Datei (Klick oder Tap).
    func selectFile(_ file: FileItem?) {
        selectedFile = file
    }

    /// Sucht rekursiv nach Dateien mit dem gegebenen Namen (einfache Textsuche).
    func searchFiles(with keyword: String) -> [FileItem] {
        func searchRecursive(_ items: [FileItem]) -> [FileItem] {
            var results: [FileItem] = []
            for item in items {
                if item.name.lowercased().contains(keyword.lowercased()) {
                    results.append(item)
                }
                if let children = item.children {
                    results.append(contentsOf: searchRecursive(children))
                }
            }
            return results
        }
        return searchRecursive(files)
    }
}
