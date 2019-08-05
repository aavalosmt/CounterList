//
//  Array.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    subscript (offset index: Int) -> Element? {
        guard index < (count - 1) else {
            return self[safe: index % (count - 1)]
        }
        return self[safe: index]
    }
    
}
