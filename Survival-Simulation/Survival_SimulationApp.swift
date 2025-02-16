//
//  Survival_SimulationApp.swift
//  Survival-Simulation
//
//  Created by Joshua Wolfson on 16/2/2025.
//

import SwiftUI

@main
struct Survival_SimulationApp: App {
    
    @State var gridHeight: Int = 20
    @State var gridWidth: Int = 20
    @State var noOfTeams: Int = 3
    @State var noOfPieces: Int = 20
    @State var noOfFrames: Int = 100
    @State var sleepTime: Double = 0.5
    @State var counts: [Int: [Int]] = [:]
    
    var body: some Scene {
        WindowGroup {
            ContentView(gridHeight: $gridHeight, gridWidth: $gridWidth, noOfTeams: $noOfTeams, noOfPieces: $noOfPieces, noOfFrames: $noOfFrames,  sleepTime: $sleepTime)
        }
        Window("Simulation", id: "simulation") {
            SimulationView(grid: Array(repeating: Array(repeating: [0, 0], count: gridWidth), count: gridHeight), noOfTeams: noOfTeams, noOfPieces: noOfPieces, noOfFrames: noOfFrames, sleepTime: sleepTime, counts: $counts)
        }
        Window("Stats", id: "stats") {
            StatsView(counts: counts)
        }
    }
}
