//
//  generatePositions.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

/**
 Generates positions for a given number within a grid.

 - Parameters:
    - number: The integer to be placed in the grid.
    - count: The number of times the integer should be placed in the grid.

 - Note:
    - The function uses a loop to place the specified integer `number` into random positions within a grid.
    - The placement continues until the integer has been added `count` times.
    - The variable `gridSize` (not defined within the function) represents the dimensions of the grid (assumed to be a square grid).
    - The variable `grid` (not defined within the function) is a 3D array where the integer `number` is placed if the position is available (i.e., the value at that position is 0).

 - Example:
    ```swift
    generatePositions(for: 2, count: 5)
    ```
 */
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
