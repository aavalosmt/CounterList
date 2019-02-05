//
//  ContentType.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

enum ContentType {
    case applicationJson
    
    var key: String {
        return "Content-Type"
    }
    
    var value: String {
        switch self {
        case .applicationJson:
            return "application/json"
        }
    }
    
}
