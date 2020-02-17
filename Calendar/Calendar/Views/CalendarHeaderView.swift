//
//  CalendarHeaderView.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView {

    @IBOutlet private (set) var mondayLabel: UILabel!
    @IBOutlet private (set) var tuesdayLabel: UILabel!
    @IBOutlet private (set) var wednesdayLabel: UILabel!
    @IBOutlet private (set) var thursdayLabel: UILabel!
    @IBOutlet private (set) var fridayLabel: UILabel!
    @IBOutlet private (set) var saturdayLabel: UILabel!
    @IBOutlet private (set) var sundayLabel: UILabel!
        
    func configure(with textColor: UIColor) {
        self.sundayLabel.textColor = textColor
        self.mondayLabel.textColor = textColor
        self.tuesdayLabel.textColor = textColor
        self.wednesdayLabel.textColor = textColor
        self.thursdayLabel.textColor = textColor
        self.fridayLabel.textColor = textColor
        self.saturdayLabel.textColor = textColor
    }
    
}
