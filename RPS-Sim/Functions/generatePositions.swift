//
//  generatePositions.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

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
