//
//  CalendarView.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    @IBOutlet private (set) var previousMonthButton: UIButton!
    @IBOutlet private (set) var yearLabel: UILabel!
    @IBOutlet private (set) var nextMonthButton: UIButton!
    @IBOutlet private (set) var collectionView: UICollectionView!
    
    private var month = Date()
    private let headerDateFormatter: DateFormatter = DateFormatter()
    private var dataSource: CalendarViewDataSourceProtocol!
    
    // MARK: - Setup
    func configure(with month: Date, dataSource: CalendarViewDataSourceProtocol) {
        self.month = month
        self.dataSource = dataSource
        self.setup()
        self.dataSource.setup(with: self.collectionView)
        self.setupYearLabel()
    }
    
    func display(today: Date) {
        self.dataSource.display(today: today)
    }
    
    func display(month: Date) {
        self.dataSource.display(month: month)
    }
    
    private func setup() {
        // TODO: - Add color config for left & right buttons
        self.previousMonthButton.tintColor = UIColor.black
        self.nextMonthButton.tintColor = UIColor.black
        self.headerDateFormatter.dateFormat = "MMMM yyyy"
    }
    
    private func setupYearLabel() {
        self.yearLabel.text = self.headerDateFormatter.string(from: self.month)
    }
    
    // MARK: - Actions
    @IBAction func previousMonthAction(_ sender: Any) {
        self.month.add(months: -1)
        self.dataSource.display(month: self.month)
        self.reloadData()
    }
    
    @IBAction func nextMonthAction(_ sender: Any) {
        self.month.add(months: 1)
        self.dataSource.display(month: self.month)
        self.reloadData()
    }
    
    private func reloadData() {
        self.setupYearLabel()
        self.collectionView.reloadData()
    }
    
}
