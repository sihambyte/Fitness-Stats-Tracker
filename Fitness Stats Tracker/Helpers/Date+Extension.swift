//
//  Date+Extension.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/17/23.
//

import Foundation

extension Date {
    static func firstDayOfWeek() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
    }
}
