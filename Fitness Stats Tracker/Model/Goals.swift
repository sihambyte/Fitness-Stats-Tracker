//
//  Goals.swift
//  Fitness Stats Tracker
//
//  Created by siham on 12/1/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Goals:Identifiable, Codable {
    @DocumentID var id: String?
    var calorieBurnGoal: Int
    var stepsGoal: Int
    var dailyWalkGoal: Int
}
