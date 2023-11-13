//
//  Fitness_Stats_TrackerApp.swift
//  Fitness Stats Tracker
//
//  Created by siham on 10/24/23.
//

import SwiftUI
import Firebase

@main
struct Fitness_Stats_TrackerApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
