//
//  ProductTotalViewModel.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol ProductTotalViewModelProtocol: ProductListViewModelProtocol {
    var total: Int { get }
}

struct ProductTotalViewModel: ProductTotalViewModelProtocol {
    var type: ProductListViewModelType
    var total: Int
}
