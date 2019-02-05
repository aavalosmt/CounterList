//
//  ProductListInteractorMock.swift
//  CounterListTests
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

@testable import CounterList

class ProductListInteractorMock: ProductListInputInteractorProtocol {
    
    var presenter: ProductListOutputInteractorProtocol?
    
    var addProductUseCase: AddProduct?
    var getProductListUseCase: GetProductList?
    var incrementProductCounterUseCase: IncrementProductCounter?
    var decrementProductCounterUseCase: DecrementProductCounter?
    var deleteProductUseCase: DeleteProduct?
    
    var getProductsWasCalled: Bool = false
    var addProductWasCalled: Bool = false
    var incrementCounterWasCalled: Bool = false
    var decrementCounterWasCalled: Bool = false
    var deleteProductWasCalled: Bool = false
    
    func getProductList() {
        getProductsWasCalled = true
    }
    
    func addProduct(title: String) {
        addProductWasCalled = true
    }
    
    func incrementCounter(id: String, count: Int) {
        incrementCounterWasCalled = true
    }
    
    func decrementCounter(id: String, count: Int) {
        decrementCounterWasCalled = true
    }
    
    func deleteProduct(id: String) {
        deleteProductWasCalled = true
    }
    
}
