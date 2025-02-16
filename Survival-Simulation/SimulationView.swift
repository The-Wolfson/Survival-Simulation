//
//  SimulationView.swift
//  Survival-Simulation
//
//  Created by Joshua Wolfson on 16/2/2025.
//

import SwiftUI
import Charts

struct SimulationView: View {
    @State var grid: [[[Int]]]
    let noOfTeams: Int
    let noOfPieces: Int
    let noOfFrames: Int
    let sleepTime: Double
    
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

    @State private var currentFrame: Int = 0
    @Binding var counts: [Int: [Int]]

    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        Grid {
            ForEach(0..<grid.count, id: \.self) { rowIndex in
                GridRow {
                    ForEach(0..<grid[rowIndex].count, id: \.self) {
                        columnIndex in
                        let cell = grid[rowIndex][columnIndex]
                        Text(symbol(for: cell[0]))
                    }
                }
                .padding(.bottom)
            }
        }
        HStack {
            VStack {
                Text("\(currentFrame)")
                ForEach(0..<(counts[currentFrame]?.count ?? 0), id: \.self) { index in
                    if let count = counts[currentFrame]?[index] {
                        if count != 0 {
                            Text("\(symbol(for: index + 1)): \(count)")
                        }
                    }
                }
                if let total = counts[currentFrame]?.reduce(0, +) {
                    Text("Σ: \(total)")
                        .foregroundStyle(
                            total != noOfTeams * noOfPieces
                            ? .red : .green)
                }
            }
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
            .chartXScale(domain: (1...(currentFrame <= 1 ? currentFrame + 1 : currentFrame)))
            .chartLegend(.hidden)
            .chartForegroundStyleScale(domain: Array(colorMapping.keys)) { series in
                colorMapping[series] ?? .teal
            }
        }
        .onAppear {
            Task {
                await run()
            }
        }
    }
    func run() async {
        Task.detached {
            for i in 1...noOfTeams {
                generatePositions(&grid, for: i, count: noOfPieces)
            }
        }

        for frame in 1...noOfFrames {
            updatePositions(&grid, noOfTeams: noOfTeams)
            currentFrame = frame
            counts[frame] = Array(repeating: 0, count: noOfTeams)

            for row in grid {
                for item in row {
                    if item[0] != 0 {
                        counts[frame]![item[0] - 1] += 1
                    }
                }
            }

            if counts[frame]!.contains(where: { $0 == counts[frame]?.reduce(0, +) }) {
                openWindow(id: "stats")
                dismissWindow()
                break
            }

            do {
                try await Task.sleep(
                    nanoseconds: UInt64(sleepTime * 1_000_000_000))
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    @Previewable @State var counts: [Int: [Int]] = [:]
    SimulationView(
        grid: Array(repeating: Array(repeating: [0, 0], count: 5), count: 5), noOfTeams: 3, noOfPieces: 2, noOfFrames: 100, sleepTime: 10, counts: $counts)
}
