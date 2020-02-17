//
//  CalendarCollectionViewCell.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import UIKit

struct CalendarCellColor {
    let text: UIColor
    let background: UIColor
    let selectedText: UIColor
    let selectedBackground: UIColor
    let todayBackground: UIColor
    let disabledText: UIColor
}

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet private (set) var dayLabel: UILabel!
    @IBOutlet private (set) var dueDateLabel: UILabel!
    @IBOutlet private (set) var scheduledPaymentView: UIView!
    
    private var colors: CalendarCellColor!
    
    func theme(with colors: CalendarCellColor, date: Date) {
        self.colors = colors
        self.display(date: date)
        self.displayDefault()
    }
    
    func displayHidden() {
        self.clearTheme()
        self.dayLabel.text = nil
        self.dueDateLabel.text = nil
    }

    func displaySelected() {
        self.clearTheme()
        self.dayLabel.layer.cornerRadius = self.getDayLabelCornerRadius()
        self.dayLabel.layer.backgroundColor = self.colors.selectedBackground.cgColor
        self.dayLabel.textColor = self.colors.selectedText
        self.dueDateLabel.textColor = self.colors.selectedText
    }
    
    func displayToday() {
        self.clearTheme()
        self.dayLabel.layer.cornerRadius = self.getDayLabelCornerRadius()
        self.dayLabel.layer.backgroundColor = self.colors.todayBackground.cgColor
        self.dayLabel.textColor = self.colors.text
    }
    
    func displayDisabled() {
        self.clearTheme()
        self.dayLabel.textColor = self.colors.disabledText
    }
    
    // MARK: - Helpers
    private func display(date: Date) {
        self.dayLabel.text = "\(date.day())"
    }
    
    private func clearTheme() {
        self.dayLabel.layer.backgroundColor = nil
        self.dueDateLabel.isHidden = true
        self.scheduledPaymentView.isHidden = true
    }
    
    private func displayDefault() {
        self.clearTheme()
        self.dayLabel.layer.backgroundColor = self.colors.background.cgColor
        self.dayLabel.textColor = self.colors.text
        self.dueDateLabel.textColor = self.colors.text
    }
    
    private func getDayLabelCornerRadius() -> CGFloat {
        let diameter = self.dayLabel.frame.height < self.dayLabel.frame.width ? self.dayLabel.frame.height : self.dayLabel.frame.width
        return diameter / 2.0
    }
    
}
