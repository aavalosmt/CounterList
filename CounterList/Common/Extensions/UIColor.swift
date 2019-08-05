//
//  UIColor.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 8/3/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(hex: Int) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
