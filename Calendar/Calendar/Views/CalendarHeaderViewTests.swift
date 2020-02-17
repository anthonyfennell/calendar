//
//  CalendarHeaderViewTests.swift
//  CalendarTests
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import XCTest
@testable import Calendar

final class CalendarHeaderViewTests: XCTestCase {

    private var view: CalendarHeaderView! = CalendarHeaderView.loadFromNib()
    private var color: UIColor! = UIColor.red
    
    override func tearDown() {
        self.view = nil
        self.color = nil
    }

    func testOutletsAreNotNil() {
        XCTAssertNotNil(self.view.sundayLabel)
        XCTAssertNotNil(self.view.mondayLabel)
        XCTAssertNotNil(self.view.tuesdayLabel)
        XCTAssertNotNil(self.view.wednesdayLabel)
        XCTAssertNotNil(self.view.thursdayLabel)
        XCTAssertNotNil(self.view.fridayLabel)
        XCTAssertNotNil(self.view.saturdayLabel)
    }
    
    func testLabelColorIsSet() {
        // when
        self.view.configure(with: self.color)
        // then
        XCTAssertEqual(self.view.sundayLabel.textColor, self.color)
    }

}
