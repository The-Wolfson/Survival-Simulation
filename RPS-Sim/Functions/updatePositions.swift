//
//  updatePositions.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

/**
 Updates the positions of items within the grid based on random directions.

 - Note:
    - The function iterates through each item in the grid.
    - If the item is not zero, it attempts to move the item in a random direction (up, right, down, or left).
    - The item is only moved if the new position is within the grid boundaries and does not match the old direction.
    - If the new position is empty, the item is moved to the new position.
    - If the new position is occupied, the `decideWinner` function determines which item remains in the new position based on their values.
 */
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
