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
let noOfTeams: Int = min(Int(CommandLine.arguments[4]) ?? 3, 9)
var grid: [[[Int]]] = Array(
    repeating: Array(repeating: [0, 0], count: gridSize), count: gridSize)

func symbol(for num: Int) -> String {
    switch num {
    case 1:
        return "🟥"
    case 2:
        return "🟧"
    case 3:
        return "🟨"
    case 4:
        return "🟩"
    case 5:
        return "🟦"
    case 6:
        return "🟪"
    case 7:
        return "🟫"
    case 8:
        return "⬜️"
    case 9:
        return "🔳"
    default:
        return "  "
    }
}

func generatePositions(for number: Int, count: Int) {
    for _ in 0..<count {
        var added = false
        while !added {
            let randCol = Int.random(in: 0..<gridSize)
            let randRow = Int.random(in: 0..<gridSize)

            if grid[randRow][randCol][0] == 0 {
                grid[randRow][randCol][0] = number
                added = true
            }
        }
    }
}

func decideWinner(num1: Int, num2: Int, totalMoves: Int = noOfTeams) -> Int {
    if num1 == num2 {
        return num1
    }

    let half = totalMoves / 2
    let diff = ((num1 - 1) - (num2 - 1) + totalMoves) % totalMoves

    if diff >= 1 && diff <= half {
        return num1
    } else {
        return num2
    }
}

func updatePositions() {
    for (rowIndex, row) in grid.enumerated() {
        for (colIndex, item) in row.enumerated() {
            let number = item[0]
            let oldDirection = item[1]
            if number != 0 {
                var moved = false
                while !moved {
                    //direction - 1: up, 2: right, 3: down, 4: left
                    let direction = Int.random(in: 1..<5)

                    var newRow = rowIndex
                    var newCol = colIndex

                    switch direction {
                    case 1: newRow = rowIndex - 1
                    case 2: newCol = colIndex + 1
                    case 3: newRow = rowIndex + 1
                    case 4: newCol = colIndex - 1
                    default: break
                    }

                    if newRow >= 0 && newRow < gridSize && newCol >= 0
                        && newCol < gridSize && oldDirection != direction
                    {

                        if grid[newRow][newCol][0] == 0 {
                            grid[newRow][newCol] = [
                                number,
                                direction > 2 ? direction - 2 : direction + 2,
                            ]
                            grid[rowIndex][colIndex] = [0, 0]
                            moved = true
                        } else {
                            let winner = decideWinner(
                                num1: grid[rowIndex][colIndex][0],
                                num2: grid[newRow][newCol][0])
                            grid[newRow][newCol] = [
                                winner,
                                direction > 2 ? direction - 2 : direction + 2,
                            ]
                            grid[rowIndex][colIndex] = [
                                winner,
                                direction > 2 ? direction - 2 : direction + 2,
                            ]
                            moved = true
                        }
                    }
                }
            }
        }
    }
}

func printGrid() {
    print("\u{001B}[2J", terminator: "")
    var output = ""

    for row in grid {
        for item in row {
            output += " \(symbol(for: item[0])) "
        }
        output += "\n"
    }

    print(output, terminator: "")
}

for i in 1...noOfTeams {
    generatePositions(for: i, count: numberOfPieces)
}

for frame in 0..<noOfFrames {
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
    print("Σ - \(total)")
    if counts.contains(where: { $0 == total }) {
        break
    }
    try await Task.sleep(nanoseconds: 50_000_000)
}

let end = CFAbsoluteTimeGetCurrent()
print("Time: \(end - start) seconds")
