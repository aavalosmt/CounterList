//
//  ProductListViewMock.swift
//  CounterListTests
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

@testable import CounterList

class ProductListViewMock: ProductListViewProtocol {
    
    var showProductsWasCalled: Bool = false
    var updateCounterWasCalled: Bool = false
    
    func showProducts(with products: [ProductListViewModelProtocol], indices: [Int]) {
        showProductsWasCalled = true
    }
    
    func showError(with error: Error) {
        
    }
    
    func didUpdateCounter(id: String, count: Int) {
        updateCounterWasCalled = true
    }
}
