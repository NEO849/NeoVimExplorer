<table>
  <tr>   
    <td>
      <img src="https://github.com/NEO849/NeoVimExplorer/blob/main/neovimexapplogo.png?raw=true" alt="NeoVimExplorer Icon" width="150" />
    </td>
    <td>
      <h1 style="color: #00bfa6;">NeoVimExplorer</h1>
      <p>Modularer Datei-Explorer im Stil von Neovim – modern, animiert & lokal.</p>
    </td>
  </tr>
</table>

![Swift](https://img.shields.io/badge/Swift-5.10-00bfa6?logo=swift&logoColor=black)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-00bfa6?logo=swift&logoColor=black)
![iOS](https://img.shields.io/badge/iOS-17%2B-00bfa6?logo=apple&logoColor=black)
![License](https://img.shields.io/badge/Lizenz-MIT-00bfa6?logo=open-source-initiative&logoColor=black)

**Datei-Explorer für iOS/macOS – mit Blur, Neon-Themes, CLI & Editor.**

---

## ![Design / Screenshots](https://img.shields.io/badge/Design-%2300bfa6?style=for-the-badge&logo=none)

<div>
  <img src="https://github.com/NEO849/NeoVimExplorer/blob/main/neovimexdummy1.png?raw=true" width="30%" />
  <img src="https://github.com/NEO849/NeoVimExplorer/blob/main/neovimexdummy2.png?raw=true" width="30%" />
  <img src="https://github.com/NEO849/NeoVimExplorer/blob/main/neovimexdummy3.png?raw=true" width="30%" />
</div>

---

## ![Funktionen](https://img.shields.io/badge/Funktionen-%2300bfa6?style=for-the-badge&logo=none)

- 🔍 Live-Datei-Explorer mit Grid-, Listen- & Kartenlayout  
- 🎨 Neon-Themes: TokyoNight, Gruvbox, Catppuccin  
- 📊 Interaktive Speicheranalyse mit Charts  
- ⚡️ Schnelle Fuzzy-Suche wie Telescope.nvim  
- ✏️ Integrierter Dateieditor für `.txt`, `.swift` etc.  
- 🖥 CLI-Terminal (ls, pwd, date, help) mit Verlauf  
- 🌈 Animierte Hintergrundbilder mit Blur & Glas-Effekt  
- 🧠 Favoritenverwaltung mit @AppStorage  
- 🔁 Reset aller Einstellungen  
- 🧩 MVVM + Repository Pattern + @Observable Swift 5.9

---

## ![Projektstruktur](https://img.shields.io/badge/Projektstruktur-%2300bfa6?style=for-the-badge&logo=none)

```mermaid
graph TD
    A[NeoVimExplorerApp.swift] --> B[ExplorerView]
    A --> C[SettingsView]
    A --> D[TerminalView]

    B --> E[ExplorerViewModel]
    B --> F[StorageChartView]
    B --> G[FileCardView]
    B --> H[QuickLookPreview]

    C --> I[SettingsViewModel]
    D --> J[TerminalViewModel]

    E --> K[FileRepository]
    I --> L[ThemeService]
    D --> M[TerminalService]

    B --> N[NeonBackgroundView]
    B --> O[FileDetailView]
    O --> K

    subgraph Views
        B
        C
        D
        F
        G
        H
        N
        O
    end

    subgraph ViewModels
        E
        I
        J
    end

    subgraph Services
        K
        L
        M
    end
```
## ![Komponenten](https://img.shields.io/badge/Komponenten-%2300bfa6?style=for-the-badge&logo=none)

| Modul              | Technologie     | Funktion                                |
|--------------------|------------------|------------------------------------------|
| `ExplorerView`     | SwiftUI          | Dateiübersicht mit Karten und Charts     |
| `TerminalView`     | SwiftUI + Logic  | CLI mit Eingabe & Ausgabe (ls, help...)  |
| `FileDetailView`   | SwiftUI + IO     | Texteditor mit Schreibzugriff            |
| `SettingsView`     | SwiftUI + Slider | Layout, Theme, Favoriten, Reset          |
| `QuickLookPreview` | UIKit via Wrapper| Vorschau von PDF, Bild, Text-Dateien     |
| `NeonBackgroundView`| Blur + Image     | Wechselt Theme-basierte Hintergrundbilder|

---

## ![Installation](https://img.shields.io/badge/Installation-%2300bfa6?style=for-the-badge&logo=none)

1. **Projekt klonen**
```bash
git clone https://github.com/NEO849/NeoVimExplorer.git
```

2. **Xcode-Projekt öffnen**
```bash
cd NeoVimExplorer && open NeoVimExplorer.xcodeproj
```

3. **App starten**
   - Schema `NeoVimExplorer` auswählen
   - `⌘R` drücken, los geht’s!

---

## ![Technologie-Stack](https://img.shields.io/badge/Technologie--Stack-%2300bfa6?style=for-the-badge&logo=none)

| Technologie       | Einsatzbereich                  |
|-------------------|----------------------------------|
| Swift 5.10        | Typensichere Programmlogik       |
| SwiftUI 5.0       | UI, State, Animation             |
| Combine           | Reactive Pipeline (optional)     |
| QuickLook         | Dateivorschau                    |
| Swift Charts      | Speicherstatistik                |
| FileManager       | Lokaler Datei-Zugriff            |
| @AppStorage       | UserDefaults für Favoriten       |
| @Observable       | Neues SwiftUI MVVM (iOS 17+)     |

---

## ![Lizenz](https://img.shields.io/badge/Lizenz-%2300bfa6?style=for-the-badge&logo=none)

- Dieses Projekt steht unter der CC0 1.0 Universal-Lizenz.  
- Siehe die [LICENSE](https://github.com/NEO849/NeoVimExplorer/blob/main/LICENSE) Datei.

---

## ![Kontakt](https://img.shields.io/badge/Kontakt-%2300bfa6?style=for-the-badge&logo=none)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Michael_Fleps-00bfa6?logo=linkedin)](https://www.linkedin.com/in/michael-fleps-neo849/)  
[![GitHub](https://img.shields.io/badge/GitHub-@MichaelFleps-00bfa6?logo=github)](https://github.com/MichaelFleps)

---

> „NeoVim trifft SwiftUI – für Entwickler, die Terminal-Liebe mit moderner UI kombinieren.“  
> – NeoVimExplorer Manifest
