//
//  UIViewUtilsTests.swift
//  CalendarTests
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import XCTest
@testable import Calendar

class DateUtilsTests: XCTestCase {

    private var march_31_2019: Date!
    private var november_10_2019: Date!
    private var december_20_2019: Date!
    private var february_1_2020: Date!
    private var today: Date! = Date()
    private var dateFormatter: DateFormatter! = DateFormatter()

    override func setUp() {
        self.dateFormatter.dateFormat = "MM/dd/yyyy"
        self.march_31_2019 = self.dateFormatter.date(from: "03/31/2019")!
        self.november_10_2019 = self.dateFormatter.date(from: "11/10/2019")!
        self.december_20_2019 = self.dateFormatter.date(from: "12/20/2019")!
        self.february_1_2020 = self.dateFormatter.date(from: "02/01/2020")!
    }
    
    override func tearDown() {
        self.november_10_2019 = nil
        self.december_20_2019 = nil
        self.february_1_2020 = nil
        self.today = nil
    }
    
    // MARK: - Components
    func testDayComponentIsValid() {
        XCTAssertTrue(self.november_10_2019.day() == 10)
    }
    
    func testMonthComponentIsValid() {
        XCTAssertTrue(self.november_10_2019.month() == 11)
    }
    
    func testYearComponentIsValid() {
        XCTAssertTrue(self.november_10_2019.year() == 2019)
    }
    
    func testDaysInMonthOfNovember2019() {
        XCTAssertTrue(self.november_10_2019.daysInMonth() == 30)
    }
    
    func testDaysInMonthOfFebruary2020() {
        XCTAssertTrue(self.february_1_2020.daysInMonth() == 29)
    }
    
    func testWeekendComponentIsTrue() {
        XCTAssertTrue(self.march_31_2019.isWeekend())
    }
    
    func testWeekendComponentIsFalse() {
        XCTAssertFalse(self.december_20_2019.isWeekend())
    }

    // MARK: - Creation
    func testCreationWithYearMonthDayIsValid() {
        // when
        let november_23_2019 = Date(year: 2019, month: 11, day: 23)
        // then
        XCTAssertTrue(november_23_2019.day() == 23)
        XCTAssertTrue(november_23_2019.month() == 11)
        XCTAssertTrue(november_23_2019.year() == 2019)
    }
    
    // MARK: - Same Day
    func testIsSameDayIsFalse() {
        XCTAssertFalse(self.december_20_2019.isSameDayAs(date: self.november_10_2019))
    }
    
    func testIsSameDayIsTrue() {
        // given
        let date = Date(year: 2019, month: 11, day: 10)
        // then
        XCTAssertTrue(self.november_10_2019.isSameDayAs(date: date))
    }
    
    func testIsSameDayOrBeforeIsFalse() {
        XCTAssertFalse(self.today.isSameDayAs(date: self.november_10_2019))
    }
    
    func testIsSameDayOrBeforeIsTrue() {
        XCTAssertTrue(self.march_31_2019.isSameDayOrBefore(date: self.today))
    }
    
    func testIsBeforeIsTrue() {
        XCTAssertTrue(self.march_31_2019.isBefore(day: self.today))
    }
    
    func testIsBeforeIsFalse() {
        XCTAssertFalse(self.today.isBefore(day: self.march_31_2019))
    }
    
    // MARK: - Mutation
    func testCreateDateAdding10Days() {
        // given
        let expectedDate = Date(year: 2019, month: 11, day: 20)
        // when
        let date = self.november_10_2019.dateAdding(days: 10)
        // then
        XCTAssertTrue(date.isSameDayAs(date: expectedDate))
    }
    
    func testMutateDateAdding10Days() {
        // given
        let expectedDate = Date(year: 2019, month: 11, day: 20)
        var date = Date(year: 2019, month: 11, day: 10)
        // when
        date.add(days: 10)
        // then
        XCTAssertTrue(date.isSameDayAs(date: expectedDate))
    }
    
    func testCreateDateAdding1Month() {
        // given
        let expectedDate = Date(year: 2019, month: 4, day: 30)
        let startDate = Date(year: 2019, month: 3, day: 31)
        // when
        let date = startDate.dateAdding(months: 1)
        // then
        XCTAssertTrue(date.isSameDayAs(date: expectedDate))
    }
    
    func testMutateDateAdding1Month() {
        // given
        let expectedDate = Date(year: 2019, month: 4, day: 30)
        var date = Date(year: 2019, month: 3, day: 31)
        // when
        date.add(months: 1)
        // then
        XCTAssertTrue(date.isSameDayAs(date: expectedDate))
    }
    
    func testFirstDayOfMonth() {
        // given
        let expectedDate = Date(year: 2019, month: 11, day: 1)
        let date = Date(year: 2019, month: 11, day: 22)
        // when
        let result = date.firstDayOfMonth()
        // then
        XCTAssertEqual(result?.month(), expectedDate.month())
        XCTAssertEqual(result?.year(), expectedDate.year())
        XCTAssertEqual(result?.day(), expectedDate.day())
    }
}
