//
//  Activity.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/17/23.
//
//
//import Foundation
//
//struct Activity: Identifiable {
//    var id: String
//    var name: String
//    var image: String
//    
//    static func allActivities() -> [Activity] {
//        return [
//            Activity(id: "activeEnergyBurned", name: "Burned Calories", image: "⚡️"),
//            Activity(id: "stepCount", name: "Step Count", image: "👣"),
//            
//            Activity(id: "distanceWalkingRunning", name: "Distance Covered", image: "🏃‍♀️"),
//
//        ]
//    }
//}
// Activity.swift

import Foundation

struct Activity: Identifiable {
    var id: String
    var name: String
    var image: String
    var goal: Int // New property for the goal
    
    @MainActor static func allActivities(authViewModel: AuthViewModel) -> [Activity] {
        return [
            Activity(id: "activeEnergyBurned", name: "Burned Calories", image: "🔥", goal: authViewModel.calorieBurnGoal ?? 0),
            Activity(id: "stepCount", name: "Steps Count", image: "👣", goal: authViewModel.stepsGoal ?? 0),
            Activity(id: "distanceWalkingRunning", name: "Distance Covered", image: "🏃‍♀️", goal: authViewModel.dailyWalkGoal ?? 0),
            Activity(id: "appleExerciseTime", name: "Workout Duration", image: "🏋️", goal: authViewModel.dailyWorkoutTime ?? 0),
        ]
    }
}


