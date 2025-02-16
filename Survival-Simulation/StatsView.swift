//
//  StatsView.swift
//  Survival-Simulation
//
//  Created by Joshua Wolfson on 16/2/2025.
//

import Charts
import SwiftUI

struct StatsView: View {
    @State var counts: [Int: [Int]] = [0: [0]]
    
    let colorMapping: [String: Color] = [
        "0": .red,
        "1": .orange,
        "2": .yellow,
        "3": .green,
        "4": .blue,
        "5": .purple,
        "6": .brown,
        "7": .white,
        "8": .gray
    ]
    
    var body: some View {
        Chart {
            ForEach(counts.keys.sorted(), id: \.self) { (frame: Int) in
                let values = counts[frame] ?? []
                ForEach(values.indices, id: \.self) { (index: Int) in
                    let series = String(index)
                    
                    LineMark(
                        x: .value("Frame", frame),
                        y: .value("Value", values[index]),
                        series: .value("Series", series)
                    )
                    .foregroundStyle(by: .value("Series", series))
                }
            }
        }
        .chartLegend(.hidden)
        .chartForegroundStyleScale(domain: Array(colorMapping.keys)) { series in
            colorMapping[series] ?? .teal
        }
    }
}

#Preview {
    StatsView(
        counts: [
            1: [1, 2, 3, 4, 5, 6, 7, 8, 9],
            2: [1, 2, 3, 4, 5, 6, 7, 8, 9],
            3: [1, 2, 3, 4, 5, 6, 7, 8, 9],
            4: [4, 5, 6, 7, 8],
            5: [7, 5, 4, 6, 8],
            6: [6, 6, 6, 6, 6],
            7: [4, 8, 5, 7, 6],
            8: [8, 6, 5, 7, 4],
            9: [7, 5, 6, 8, 4],
            10: [6, 7, 5, 8, 4],
            11: [5, 6, 7, 6, 6],
            12: [6, 5, 8, 7, 4],
            13: [7, 4, 6, 5, 8],
            14: [5, 6, 8, 6, 5],
            15: [8, 5, 7, 4, 6],
            16: [6, 7, 5, 6, 6],
            17: [4, 7, 6, 8, 5],
            18: [5, 7, 6, 6, 6],
            19: [7, 4, 6, 8, 5],
            20: [6, 8, 5, 6, 5],
            21: [5, 8, 4, 7, 6],
            22: [6, 6, 7, 5, 6],
            23: [8, 6, 5, 5, 6],
            24: [7, 6, 6, 5, 6],
            25: [6, 7, 6, 5, 6],
            26: [5, 5, 7, 8, 5],
            27: [7, 5, 6, 5, 7],
            28: [6, 5, 7, 6, 6],
            29: [8, 6, 5, 9, 2],
            30: [7, 5, 7, 5, 6],
        ]
    )
}
