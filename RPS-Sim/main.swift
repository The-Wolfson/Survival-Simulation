//
//  main.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 14/2/2025.
//

import Foundation

let start = CFAbsoluteTimeGetCurrent()

guard CommandLine.arguments.count != 4 else {
    print(
        "Insufficient arguments. Usage: <gridSize> <numberOfPieces> <noOfFrames> <noOfTeams>"
    )
    exit(1)
}

let gridSize: Int = Int(CommandLine.arguments[1]) ?? 40
let numberOfPieces: Int = Int(CommandLine.arguments[2]) ?? 100
let noOfFrames: Int = Int(CommandLine.arguments[3]) ?? 100
let noOfTeams: Int = min((Int(CommandLine.arguments[4]) ?? 3), 9) | 1
var grid: [[[Int]]] = Array(
    repeating: Array(repeating: [0, 0], count: gridSize), count: gridSize)

for i in 1...noOfTeams {
    generatePositions(for: i, count: numberOfPieces)
}

for frame in 1...noOfFrames {
    updatePositions()
    printGrid()
    print()
    print(frame)

    var counts = Array(repeating: 0, count: noOfTeams)
    for row in grid {
        for item in row {
            if item[0] != 0 {
                counts[item[0] - 1] += 1
            }
        }
    }

    for (index, count) in counts.enumerated() {
        if count != 0 {
            print(symbol(for: index + 1), count, separator: ": ")
        }
    }

    let total = counts.reduce(0, +)
    print(total != noOfTeams * numberOfPieces ? "\u{001B}[31m" : "\u{001B}[32m" ,"Σ: \(total)", "\u{001B}[0m")
    if counts.contains(where: { $0 == total }) {
        break
    }
    try await Task.sleep(nanoseconds: 50_000_000)
}

let end = CFAbsoluteTimeGetCurrent()
print("Time: \(end - start) seconds")
