//
//  updatePositions.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

func updatePositions(_ grid: inout [[[Int]]], noOfTeams: Int) {
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

                    if newRow >= 0 && newRow < grid.count && newCol >= 0
                        && newCol < grid[0].count && oldDirection != direction
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
                                num2: grid[newRow][newCol][0], noOfTeams: noOfTeams)
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
