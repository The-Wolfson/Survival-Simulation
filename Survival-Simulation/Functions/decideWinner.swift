//
//  decideWinner.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

/**
 Determines the winner between two integers based on specific conditions.

 - Parameters:
    - num1: The first integer.
    - num2: The second integer.

 - Returns: The winning integer.
 
 - Note:
    - If `num1` and `num2` are equal, the function returns `num1`.
    - The function calculates the difference between the two numbers and uses modulo arithmetic to determine the winner.
    - The variable `noOfTeams` (not defined within the function) represents the total number of teams.
    - The function assumes that `num1` and `num2` are within the range of 1 to `noOfTeams`.

 - Example:
    ```swift
    decideWinner(num1: 3, num2: 9) //Returns 9
    ```
 */
func decideWinner(num1: Int, num2: Int) -> Int {
    if num1 == num2 {
        return num1
    }

    let half = noOfTeams / 2
    let diff = ((num1 - 1) - (num2 - 1) + noOfTeams) % noOfTeams

    if diff >= 1 && diff <= half {
        return num1
    } else {
        return num2
    }
}
