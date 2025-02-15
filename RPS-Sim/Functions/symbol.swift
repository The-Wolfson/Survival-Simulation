//
//  symbol.swift
//  RPS-Sim
//
//  Created by Joshua Wolfson on 15/2/2025.
//

import Foundation

/**
 Returns the corresponding symbol for a given integer.

 - Parameters:
    - num: The integer for which the symbol is to be returned.

 - Returns: A string representing the symbol for the given integer.

 - Note:
    - The function uses a `switch` statement to return specific symbols for integers from 1 to 9.
    - If the integer does not match any case, the function returns an empty string with two spaces.

 - Example:
    ```swift
    symbol(for: 3) // Returns "🟨"
    ```

 - Symbol Mapping:
    - 1: 🟥
    - 2: 🟧
    - 3: 🟨
    - 4: 🟩
    - 5: 🟦
    - 6: 🟪
    - 7: 🟫
    - 8: ⬜️
    - 9: 🔳
 */
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
