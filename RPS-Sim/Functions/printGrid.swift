//
//  printGrid.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

/**
 Prints the current state of the grid to the console.

 - Note:
    - The function clears the console before printing the grid.
    - The grid is represented by a 2D array `grid`, where each element is processed to get its corresponding symbol using the `symbol(for:)` function.
 */
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
