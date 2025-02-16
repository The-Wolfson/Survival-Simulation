//
//  generatePositions.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

func generatePositions(_ grid: inout [[[Int]]], for number: Int, count: Int) {
    for _ in 0..<count {
        var added = false
        while !added {
            let randRow = Int.random(in: 0..<grid.count)
            let randCol = Int.random(in: 0..<grid[randRow].count)

            if grid[randRow][randCol][0] == 0 {
                grid[randRow][randCol][0] = number
                added = true
            }
        }
    }
}
