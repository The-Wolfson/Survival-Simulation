//
//  symbol.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

func symbol(for num: Int) -> String {
    switch num {
    case 1:
        return "🟥"
    case 2:
        return "🟧"
    case 3:
        return "🟨"
    case 4:
        return "🟩"
    case 5:
        return "🟦"
    case 6:
        return "🟪"
    case 7:
        return "🟫"
    case 8:
        return "⬜️"
    case 9:
        return "🔳"
    default:
        return "  "
    }
}
