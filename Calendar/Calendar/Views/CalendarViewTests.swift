//
//  CalendarViewTests.swift
//  CalendarTests
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import XCTest
@testable import Calendar

final class CalendarViewTests: XCTestCase {

    private var view: CalendarView!

    override func setUp() {
        let today = Date()
        let dueDate = today.dateAdding(days: 5)
        let color = UIColor.red
        let colors = CalendarCellColor(text: color, background: color, selectedText: color, selectedBackground: color, todayBackground: color, disabledText: color)
        self.view = CalendarViewFactory.makeCalendarView(with: today, selectedDate: today, minimumDate: dueDate, colors: colors, delegate: nil)
    }
    
    override func tearDown() {
        self.view = nil
    }

    func testOutletsAreNotNil() {
        XCTAssertNotNil(self.view.nextMonthButton)
        XCTAssertNotNil(self.view.previousMonthButton)
        XCTAssertNotNil(self.view.collectionView)
        XCTAssertNotNil(self.view.yearLabel)
    }
    
    func testActionsAreNotNil() {
        XCTAssertNotNil(self.view.previousMonthButton.actions(forTarget: self.view, forControlEvent: .touchUpInside))
        XCTAssertNotNil(self.view.nextMonthButton.actions(forTarget: self.view, forControlEvent: .touchUpInside))
    }
    
    func testCalendarDisplaysCells() {
        XCTAssertTrue(self.view.collectionView.numberOfItems(inSection: 0) > 0)
    }

}
