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

import Cocoa

func createTextImage() -> NSImage {
    let font = NSFont.systemFont(ofSize: 50)
    let text = grid.map { row in
        row.map { "\(symbol(for: $0[0]))" }.joined(separator: " ")
    }.joined(separator: "\n")

    let image = NSImage(size: NSSize(width: 704, height: 1920), flipped: false) { (rect) -> Bool in
        text.draw(in: rect, withAttributes: [.font: font])
        return true
    }
    
    return image
}

func saveImage(image: NSImage, to url: URL) {
    // Create an image representation to save as PNG
    if let imageData = image.tiffRepresentation,
       let bitmap = NSBitmapImageRep(data: imageData) {
        let pngData = bitmap.representation(using: .png, properties: [:])
        
        do {
            try pngData?.write(to: url)
            print("Image saved successfully to \(url.path)")
        } catch {
            print("Failed to save image: \(error)")
        }
    }
}
