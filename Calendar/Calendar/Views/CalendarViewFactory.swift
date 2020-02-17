//
//  CalendarViewFactory.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import UIKit

class CalendarViewFactory {
    
    static func makeCalendarView(with month: Date, selectedDate: Date, minimumDate: Date?, colors: CalendarCellColor, delegate: CalendarViewDataSourceDelegate?) -> CalendarView {
        let view: CalendarView = CalendarView.loadFromNib()
        let dataSource = CalendarViewDataSource(month: month, selectedDate: selectedDate, minimumDate: minimumDate, colors: colors, delegate: delegate)
        view.configure(with: month, dataSource: dataSource)
        return view
    }
    
}
