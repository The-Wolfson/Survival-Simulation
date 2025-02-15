//
//  printGrid.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

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
