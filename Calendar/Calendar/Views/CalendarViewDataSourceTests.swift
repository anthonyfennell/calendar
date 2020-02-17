//
//  CalendarViewDataSourceTests.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import XCTest
@testable import Calendar

final class CalendarViewDataSourceTests: XCTestCase {

    private var dataSource: CalendarViewDataSource!
    private var november2019: Date! = Date(year: 2019, month: 11, day: 1)
    private var december2019: Date! = Date(year: 2019, month: 12, day: 1)
    private var may2020: Date! = Date(year: 2020, month: 05, day: 10)
    
    override func setUp() {
        let date = Date()
        let color = UIColor.blue
        let colors = CalendarCellColor(text: color, background: color, selectedText: color, selectedBackground: color, todayBackground: color, disabledText: color)
        self.dataSource = CalendarViewDataSource(month: date, selectedDate: date, minimumDate: date, colors: colors, delegate: nil)
    }

    override func tearDown() {
        self.dataSource = nil
        self.november2019 = nil
        self.december2019 = nil
    }

    func test_whenMonthDecember2019_evaluateNumberOfItemsIsValid() {
        // when
        self.dataSource.display(month: self.december2019)
        // then
        XCTAssertEqual(self.dataSource.numberOfItemsInSection(), 35)
    }
    
    func test_whenMonthMay2020_evaluateNumberOfItemsIsValid() {
        // when
        self.dataSource.display(month: self.may2020)
        // then
        XCTAssertEqual(self.dataSource.numberOfItemsInSection(), 42)
    }
    
    func testLeadingCellIsHidden() {
        // given
        let hiddenLeadingIndexPath = IndexPath(row: 4, section: 0)
        // when
        self.dataSource.display(month: self.november2019)
        // then
        XCTAssertTrue(self.dataSource.isCellHidden(for: hiddenLeadingIndexPath))
    }
    
    func testTrailingCellIsHidden() {
        // given
        let hiddenTrailingIndexPath = IndexPath(row: 31, section: 0)
        // when
        self.dataSource.display(month: self.december2019)
        // then
        XCTAssertTrue(self.dataSource.isCellHidden(for: hiddenTrailingIndexPath))
    }
    
    func testLeadingCellIsShown() {
        // given
        let december1IndexPath = IndexPath(row: 0, section: 0)
        // when
        self.dataSource.display(month: self.december2019)
        // then
        XCTAssertFalse(self.dataSource.isCellHidden(for: december1IndexPath))
    }
    
    func testTrailingCellIsShown() {
        // given
        let december31IndexPath = IndexPath(row: 30, section: 0)
        // when
        self.dataSource.display(month: self.december2019)
        // then
        XCTAssertFalse(self.dataSource.isCellHidden(for: december31IndexPath))
    }
    
    func testDateForIndexPathIsValid() {
        // given
        let december_10_2019_indexPath = IndexPath(row: 9, section: 0)
        let december_10_2019 = Date(year: 2019, month: 12, day: 10)
        // when
        self.dataSource.display(month: self.december2019)
        // then
        XCTAssertTrue(december_10_2019.isSameDayAs(date: self.dataSource.getDate(for: december_10_2019_indexPath)))
    }

}
