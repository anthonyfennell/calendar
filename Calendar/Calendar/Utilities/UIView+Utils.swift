//
//  UIView+Utils.swift
//  Calendar
//
//  Created by Anthony Fennell on 2/17/20.
//  Copyright © 2020 Anthony Fennell. All rights reserved.
//

import UIKit

extension UIView {
    static func loadFromNib<T>(nibName: String? = nil) -> T {
        let nibName = nibName != nil ? nibName! : String(describing: self)
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        return nib.instantiate(withOwner: self, options: nil)[0] as! T
    }
    
    var frameHeight: CGFloat {
        return self.frame.height
    }
    
    var frameWidth: CGFloat {
        return self.frame.width
    }
    
    func addFullShadowRadius() {
        self.layer.cornerRadius = 2.0
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = UIColor.lightGray.cgColor
    }
}

