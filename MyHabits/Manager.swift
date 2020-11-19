//
//  Manager.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 14.11.2020.
//

import UIKit

// class describes some logical methods

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
    
//    let dateFormatter = DateFormatter()
//
//    func timeFormatter(date: Date) -> String {
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        let stringDate = dateFormatter.string(from: date)
//        return stringDate
//    }
    
}
