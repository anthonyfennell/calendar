//
//  CalendarViewDataSource.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import UIKit

protocol CalendarViewDataSourceDelegate: class {
    func calendarViewDataSource(_ dataSource: CalendarViewDataSource, didReceiveSelection date: Date)
}

protocol CalendarViewDataSourceProtocol: class {
    func setup(with collectionView: UICollectionView)
    func display(month: Date)
    func display(today: Date)
    func isCellHidden(for indexPath: IndexPath) -> Bool
    func getDate(for indexPath: IndexPath) -> Date
    func configure(cell: CalendarCollectionViewCell, for indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, didSelect indexPath: IndexPath)
    func numberOfItemsInSection() -> Int
}

class CalendarViewDataSource: NSObject, CalendarViewDataSourceProtocol {
    var today: Date
    var month: Date
    var selectedDate: Date
    var minimumDate: Date?
    var firstOfMonth = Date()
    var selectedIndexPath: IndexPath?
    var daysInMonth: Int = 0
    var colors: CalendarCellColor!
    
    private let itemsPerRow: Int = 7
    private let cellReuseIdentifier = "default_cell"
    private let headerReuseIdentifier = "header"
    private let collectionViewHeaderHeight: CGFloat = 22.0
    
    private var cellCount: Int = 0
    private var leadingCellCount: Int = 0
    private var trailingCellCount: Int = 0
    private weak var delegate: CalendarViewDataSourceDelegate?

    // MARK: - Setup
    init(today: Date = Date(), month: Date, selectedDate: Date = Date(),
         minimumDate: Date? = nil, colors: CalendarCellColor,
         delegate: CalendarViewDataSourceDelegate?) {
        self.today = today
        self.month = month
        self.selectedDate = selectedDate
        self.minimumDate = minimumDate
        self.colors = colors
        self.delegate = delegate
        super.init()
        self.setup()
    }
    
    func display(today: Date) {
        self.today = today
        self.setup()
    }
    
    func display(month: Date) {
        self.month = month
        self.setup()
    }

    func setup(with collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: CalendarCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: self.cellReuseIdentifier)
        collectionView.register(UINib(nibName: String(describing: CalendarHeaderView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerReuseIdentifier)
    }
    
    private func setup() {
        self.daysInMonth = self.month.daysInMonth()
        self.firstOfMonth = Date(year: self.month.year(), month: self.month.month(), day: 1)
        let daysInMonth = self.month.daysInMonth()
        self.leadingCellCount = self.firstOfMonth.weekDay() - 1
        let lastDayOfMonth = self.firstOfMonth.dateAdding(days: daysInMonth - 1)
        self.trailingCellCount = self.itemsPerRow - lastDayOfMonth.weekDay()
        self.cellCount = self.leadingCellCount + daysInMonth + self.trailingCellCount
    }
    
    func numberOfItemsInSection() -> Int {
        return self.cellCount
    }
    
    func isCellHidden(for indexPath: IndexPath) -> Bool {
        if indexPath.row < self.leadingCellCount {
            return true
        } else if indexPath.row >= self.leadingCellCount + self.daysInMonth {
            return true
        } else {
            return false
        }
    }
    
    func getDate(for indexPath: IndexPath) -> Date {
        return self.firstOfMonth.dateAdding(days: indexPath.row - self.leadingCellCount)
    }
    
    func configure(cell: CalendarCollectionViewCell, for indexPath: IndexPath) {
        let date = self.getDate(for: indexPath)
        cell.theme(with: self.colors, date: date)

        if self.isCellHidden(for: indexPath) {
            cell.displayHidden()
        } else if date.isBefore(day: self.minimumDate) {
            cell.displayDisabled()
        } else {
            if date.isSameDayAs(date: self.selectedDate) {
                cell.displaySelected()
                self.selectedIndexPath = indexPath
            } else if date.isSameDayAs(date: self.today) {
                cell.displayToday()
            }
        }
    }
    
    // MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelect indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
        let date = self.getDate(for: indexPath)
        if !self.isCellHidden(for: indexPath) && !date.isBefore(day: self.minimumDate) {
            let deselectIndexPath = self.selectedIndexPath
            self.selectedIndexPath = indexPath
            self.selectedDate = date
            self.deselect(indexPath: deselectIndexPath, with: collectionView)
            self.configure(cell: cell, for: indexPath)
            self.delegate?.calendarViewDataSource(self, didReceiveSelection: date)
        }
    }
    
    func deselect(indexPath: IndexPath?, with collectionView: UICollectionView) {
        if let indexPath = indexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
            self.configure(cell: cell, for: indexPath)
        }
    }
}

extension CalendarViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as! CalendarCollectionViewCell
        self.configure(cell: cell, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.collectionViewHeaderHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerReuseIdentifier, for: indexPath) as! CalendarHeaderView
            header.configure(with: self.colors.text)
            header.backgroundColor = UIColor.clear
            return header
        }
        return UICollectionReusableView()
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView(collectionView, didSelect: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rect = collectionView.bounds
        let itemsPerRow: CGFloat = CGFloat(self.itemsPerRow)
        let cellWidth = (rect.size.width - itemsPerRow) / itemsPerRow
        let rows = CGFloat(collectionView.numberOfItems(inSection: 0)) / itemsPerRow
        let cellHeight = (rect.size.height - self.collectionViewHeaderHeight - rows) / rows
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
