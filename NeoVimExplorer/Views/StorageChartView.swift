//
//  StorageChartView.swift
//  NeoVimExplorer
//
//  Created by Michael Fleps on 25.05.25.
//

import SwiftUI
import Charts

/// Zeigt eine grafische Übersicht des Gerätespeichers an.
/// Jeder Speicherbereich (Apps, Fotos etc.) wird farblich dargestellt.
struct StorageChartView: View {
    
    let storageInfo: StorageInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Speicherübersicht")
                .font(.title2.bold())
                .foregroundStyle(.primary)
                .padding(.leading)

            // Chart iteriert über die 'categories' der StorageInfo
            Chart(storageInfo.categories) { category in
                SectorMark(
                    angle: .value("Speicher (GB)", category.usageInGB),
                    innerRadius: .ratio(0.6),
                    angularInset: 1.5
                )
                // Farbe basierend auf der Kategorie-ID (enum rawValue)
                .foregroundStyle(by: .value("Kategorie", category.name))
                .annotation(position: .overlay) {
                    // Prozentualen Anteils der Kategorie
                    if let percent = category.usagePercent {
                        Text("\(percent, format: .percent)")
                            .font(.caption2)
                            .foregroundStyle(.white)
                    } else {
                        Text("\(category.usageInGB, specifier: "%.1f") GB")
                            .font(.caption2)
                            .foregroundStyle(.white)
                    }
                }
            }
            .chartLegend(position: .bottom)
            .frame(height: 220)
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 6)
            .padding(.horizontal)

            // Gesamtverbrauch
            HStack {
                Text("Gesamt: \(storageInfo.totalInGB, specifier: "%.1f") GB")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Genutzt: \(storageInfo.usedInGB, specifier: "%.1f") GB")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top, 5)
    }
}

#Preview {
    let mockStorageInfo = StorageInfo(
        totalInGB: 256.0,
        usedInGB: 100.0,
        categories: [
            StorageCategory(id: .apps, usageInGB: 40.0, usagePercent: 0.4),
            StorageCategory(id: .pictures, usageInGB: 30.0, usagePercent: 0.3),
            StorageCategory(id: .dokuments, usageInGB: 20.0, usagePercent: 0.2),
            StorageCategory(id: .other, usageInGB: 10.0, usagePercent: 0.1)
        ]
    )
    StorageChartView(storageInfo: mockStorageInfo)
        .padding()
}
