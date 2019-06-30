//
//  UIView.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import UIKit

extension UIView {
    
    func customCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func customBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        clipsToBounds = true
    }
}
