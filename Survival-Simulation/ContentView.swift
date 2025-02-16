//
//  ContentView.swift
//  Survival-Simulation
//
//  Created by Joshua Wolfson on 16/2/2025.
//

import SwiftUI

struct ContentView: View {
    @Binding var gridHeight: Int
    @Binding var gridWidth: Int
    @Binding var noOfTeams: Int
    @Binding var noOfPieces: Int
    @Binding var noOfFrames: Int
    @Binding var sleepTime: Double  //milliseconds 1000000

    @Environment(\.openWindow) var openWindow
    var body: some View {
        Form {
            HStack {
                TextField("Width", value: $gridWidth, format: .number)
                Text("x")
                TextField("Height", value: $gridHeight, format: .number)
            }
            Stepper(
                "Number of Teams \(noOfTeams)", value: $noOfTeams, in: 3...9,
                step: 2)
            Stepper(
                "Number of Pieces \(noOfPieces)", value: $noOfPieces,
                in: 1...((gridWidth * gridHeight) / noOfTeams), step: 1)
            Text("Σ \(noOfTeams * noOfPieces)")
            TextField("Number of Frames", value: $noOfFrames, format: .number)
            TextField("Sleep Time (seconds)", value: $sleepTime, format: .number)
            Button("Simulate") {
                openWindow(id: "simulation")
            }
        }
    }
}

#Preview {
    ContentView(
        gridHeight: .constant(20), gridWidth: .constant(20),
        noOfTeams: .constant(5), noOfPieces: .constant(20),
        noOfFrames: .constant(20), sleepTime: .constant(20))
}
