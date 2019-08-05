//
//  ProductList.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

struct ProductList: Codable {
    
    var dataset: Dataset
    
    struct Dataset: Codable {
        var data: [Product]
    }
    
}
