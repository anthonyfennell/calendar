//
//  Date+Utils.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import Foundation

extension Date {
    init(year : Int, month : Int, day : Int) {
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        self.init(timeInterval:0, since:calendar.date(from: dateComponent)!)
    }
    
    fileprivate var calender: Calendar {
        return Calendar.current
    }
    
    // MARK: - Component Values
    func day() -> Int {
        return self.calender.component(.day, from: self)
    }
    
    func weekDay() -> Int {
        return self.calender.component(.weekday, from: self)
    }
    
    func month() -> Int {
        return self.calender.component(.month, from: self)
    }
    
    func year() -> Int {
        return self.calender.component(.year, from: self)
    }
    
    func daysInMonth() -> Int {
        let range = self.calender.range(of: .day, in: .month, for: self)
        return (range?.count)!
    }
    
    // MARK: - Mutate
    mutating func add(days: Int) {
        self = self.dateAdding(days: days)
    }
    
    mutating func add(months: Int) {
        self = self.dateAdding(months: months)
    }
    
    // MARK: - Create
    func dateAdding(days: Int) -> Date {
        return self.calender.date(byAdding: .day, value: days, to: self)!
    }
    
    func dateAdding(months: Int) -> Date {
        return self.calender.date(byAdding: .month, value: months, to: self)!
    }
    
    // MARK: - Evaluations
    func isWeekend() -> Bool {
        let weekday = self.calender.component(.weekday, from: self)
        return (weekday == 1 || weekday == 7)
    }
    
    // MARK: Day
    func isSameDayOrBefore(date: Date) -> Bool {
        return self < date || isSameDayAs(date: date)
    }
    
    func isSameDayAs(date: Date) -> Bool {
        return (self.year() == date.year() && self.month() == date.month() && self.day() == date.day())
    }
    
    func isBefore(day: Date?) -> Bool {
        guard let day = day else { return false }
        return self < day && !self.isSameDayAs(date: day)
    }
    
    func firstDayOfMonth() -> Date? {
        if let firstDayOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))) {
            return firstDayOfMonth
        } else {
            return nil
        }
    }
}
