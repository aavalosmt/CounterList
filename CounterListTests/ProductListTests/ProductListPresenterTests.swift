//
//  ProductListPresenterTests.swift
//  CounterListTests
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import XCTest
@testable import CounterList

class ProductListPresenterTests: XCTestCase {
    
    var presenter: ProductListPresenterProtocol!
    var interactor: ProductListInteractorMock!
    var router: ProductListRouterMock!
    var view: ProductListViewMock!
    
    override func setUp() {
        super.setUp()
        interactor = ProductListInteractorMock()
        router = ProductListRouterMock()
        view = ProductListViewMock()
        presenter = ProductListPresenter(
            interactor: interactor,
            router: router,
            view: view)
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
        router = nil
        interactor = nil
    }
    
    func testCallToGetProducts() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.getProductsWasCalled)
    }
    
    func testCallToAddProduct() {
        presenter.addProduct(title: "123")
        XCTAssertTrue(interactor.addProductWasCalled)
    }
    
    func testCallToIncrementCounter() {
        presenter.incrementCounter(id: "123", count: 1)
        XCTAssertTrue(interactor.incrementCounterWasCalled)
    }
    
    func testCallToDecrementCounter() {
        presenter.decrementCounter(id: "123", count: 1)
        XCTAssertTrue(interactor.decrementCounterWasCalled)
    }
    
    func testCallToDeleteProduct() {
        presenter.deleteProduct(id: "123")
        XCTAssertTrue(interactor.deleteProductWasCalled)
    }
    
}
