//
//  ProductListServiceTests.swift
//  CounterListTests
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import XCTest
@testable import CounterList

class ProductListServiceTests: XCTestCase {

    var getProductsUseCase: GetProductList!
    
    override func setUp() {
        super.setUp()
        getProductsUseCase = GetProductListImpl(
            service: ProductListWebService()
        )
    }
    
    override func tearDown() {
        super.tearDown()
        getProductsUseCase = nil
    }
    
    func testThatRetrievesProducts() {
        let expectation = self.expectation(description: "GetProducts")
        var productList: [ProductEntity] = []
        getProductsUseCase.execute(usingCache: false, completion: { response in
            switch response {
            case .success(let products):
                productList = products
            default: break
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 30.0)
        XCTAssertTrue(!productList.isEmpty)
    }
  

}
