//
//  Manager.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 14.11.2020.
//

import UIKit

// class implements some logical methods

class Manager: NSObject {
    
   static let shared: Manager = Manager()
    
    //MARK: - Dates data communication
    
    var index: Int?
    
    var datesStringArray: [String] = {
        let array: [String] = [String]()
        return array
    }()
    
    func sendHabitToNewVC(habit: Habit) -> [String] {
        var datesStringArray: [String] = []
        for date in 0..<HabitsStore.shared.dates.count {
            if HabitsStore.shared.habit(habit, isTrackedIn: HabitsStore.shared.dates[date]) == true {
                datesStringArray.append(HabitsStore.shared.trackDateString(forIndex: date)!)
                }
            }
        return datesStringArray
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    func convertDateToString() -> [String] {
        var stringDates: [String] = []
        for date in 0..<HabitsStore.shared.dates.count {
                stringDates.append(dateFormatter.string(from: HabitsStore.shared.dates[date]))
        }
        return stringDates
    }
    
}
