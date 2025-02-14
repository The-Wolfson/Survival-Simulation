//
//  main.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 14/2/2025.
//

import Foundation

let start = CFAbsoluteTimeGetCurrent()
//1: Rock, 2: Paper, 3: Scissors
let rockSymbol = "🟩"  //"🪨" //
let paperSymbol = "🟧"  //"📄"//
let scissorsSymbol = "🟦"  //"✂️ "

let gridSize: Int = Int(CommandLine.arguments[1]) ?? 40
var grid: [[Int]] = Array(
    repeating: Array(repeating: 0, count: gridSize), count: gridSize)

func generatePositions(for number: Int, count: Int) {
    for _ in 0..<count {
        let randCol = Int.random(in: 0..<gridSize)
        let randRow = Int.random(in: 0..<gridSize)

        if grid[randRow][randCol] == 0 {
            grid[randRow][randCol] = number
        } else {
            grid[randCol][randRow] = number
        }
    }
}

func decideWinner(num1: Int, num2: Int) -> Int {
    if num1 == num2 {
        return num1
    }
    if num1 + num2 == 3 {  //Rock vs Paper
        return 2  //Paper
    }
    if num1 + num2 == 4 {  //Rock vs Scissors
        return 1  //Rock
    }
    if num1 + num2 == 5 {  //Paper vs Scissors
        return 3  //Scissors
    }
    return 0
}

func updatePositions() {
    for (rowIndex, row) in grid.enumerated() {
        for (colIndex, item) in row.enumerated() {
            if item != 0 {
                //direction - 0: up, 1: right, 2: down, 3: left
                let direction = Int.random(in: 0..<4)

                var newRow = rowIndex
                var newCol = colIndex

                switch direction {
                case 0: newRow = rowIndex - 1
                case 1: newCol = colIndex + 1
                case 2: newRow = rowIndex + 1
                case 3: newCol = colIndex - 1
                default: break
                }

                if newRow >= 0 && newRow < gridSize && newCol >= 0
                    && newCol < gridSize
                {

                    if grid[newRow][newCol] == 0 {
                        grid[newRow][newCol] = item
                        grid[rowIndex][colIndex] = 0
                    } else {
                        let winner = decideWinner(
                            num1: grid[rowIndex][colIndex],
                            num2: grid[newRow][newCol])
                        grid[newRow][newCol] = winner
                        grid[rowIndex][colIndex] = winner
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
            switch item {
            case 1:
                output += " \(rockSymbol) "
            case 2:
                output += " \(paperSymbol) "
            case 3:
                output += " \(scissorsSymbol) "
            default:
                output += "    "
            }
        }
        output += "\n"
        //output += "\n" + Array(repeating: "–", count: gridSize * 5).joined() + "\n"
    }

    print(output, terminator: "")
}

for i in 1...3 {
    generatePositions(for: i, count: Int(CommandLine.arguments[2]) ?? 100)
}

for frame in 0..<(Int(CommandLine.arguments[3]) ?? 100) {
    updatePositions()
    printGrid()
    print()
    print(frame)

    var scissorCount = 0
    var rockCount = 0
    var paperCount = 0
    for row in grid {
        for item in row {
            item == 3
                ? scissorCount += 1
                : item == 1 ? rockCount += 1 : item == 2 ? paperCount += 1 : ()
        }
    }
    let total = rockCount + paperCount + scissorCount
    print(rockSymbol, rockCount, separator: ": ")
    print(paperSymbol, paperCount, separator: ": ")
    print(scissorsSymbol, scissorCount, separator: ": ")
    print("Σ - \(total)")
    if rockCount == total || paperCount == total || scissorCount == total {
        break
    }
    try await Task.sleep(nanoseconds: 100_000_000)
}

let end = CFAbsoluteTimeGetCurrent()
print("Time: \(end - start) seconds")
