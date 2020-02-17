//
//  ViewController.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private (set) var stackView: UIStackView!
    
    private let calendarHeight: CGFloat = 250
    private weak var calendarView: CalendarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let today = Date()
        let minimumDate = today.dateAdding(days: -1)
        let todayBackgroundColor = UIColor(white: 0.8, alpha: 0.7)
        let colors = CalendarCellColor(text: .black, background: .white, selectedText: .white,
                                       selectedBackground: .orange, todayBackground: todayBackgroundColor,
                                       disabledText: .lightGray)
        let view = CalendarViewFactory.makeCalendarView(with: today, selectedDate: today,
                                                        minimumDate: minimumDate, colors: colors,
                                                        delegate: self)
        view.frame = CGRect(x: 0, y: 0, width: self.view.frameWidth, height: self.calendarHeight)
        self.stackView.addArrangedSubview(view)
        self.calendarView = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let today = Date()
        self.calendarView?.display(today: today)
        self.calendarView?.display(month: today)
    }

}

extension ViewController: CalendarViewDataSourceDelegate {
    func calendarViewDataSource(_ dataSource: CalendarViewDataSource, didReceiveSelection date: Date) {
        print("Date selected: \(date)")
    }
}
