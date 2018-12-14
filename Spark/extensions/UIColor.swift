//
//  UIColor.swift
//  Spark
//
//  Created by issd on 14/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    // Setup custom colours we can use throughout the app using hex values
    static let sparkGreen = UIColor(hex: 0x03BFFD1)
    static let backgroundGrey = UIColor(hex: 0xF9F9F9)
    //static let rgbRed = UIColor(red: 255, green: 0, blue: 0)
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
