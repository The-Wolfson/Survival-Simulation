//
//  decideWinner.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

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
