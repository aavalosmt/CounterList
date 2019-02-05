//
//  ProductListViewModelFactory.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

class ProductListViewModelFactory {
    
    func createModels(from productList: inout [ProductListViewModelProtocol]) {
        let total = productList.compactMap({
                        ($0 as? ProductViewModelProtocol)?.count
                    }).reduce(0, { $0 + $1 })
        
        let totalViewModel = ProductTotalViewModel(type: .total, total: total)
        productList.append(totalViewModel)
    }
    
}
