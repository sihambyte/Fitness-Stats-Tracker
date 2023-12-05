//
//  HealthStat.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/17/23.
//

import Foundation
import HealthKit

struct HealthStat: Identifiable{
    let id = UUID()
    let stat: HKQuantity?
    let date: Date
    
    
}
