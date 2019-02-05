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

    var stub: GeneralTestsStubSetup!
    var getProductsUseCase: GetProductList!
    var addProductsUseCase: AddProduct!
    var deleteProductsUseCase: DeleteProduct!
    
    override func setUp() {
        super.setUp()
        stub = GeneralTestsStubSetup()
        setupGetProductsStub()
        setupAddProductsStub()
        
        getProductsUseCase = GetProductListImpl(
            service: ProductListWebService()
        )
        addProductsUseCase = AddProductImpl(
            service: AddProductWebService()
        )
        deleteProductsUseCase = DeleteProductImpl(
            service: DeleteProductWebService()
        )
    }
    
    override func tearDown() {
        super.tearDown()
        getProductsUseCase = nil
    }
    
    private func setupGetProductsStub() {
        let url = EndpointManager.shared.getUrl(for: .GetProducts)!
        let jsonFile = CommonUnitTestsConstants.Stubs.getProductsSuccessResponse.rawValue
        stub.registerCustomStub(for: url, resource: jsonFile, status: .OK, isDown: false)
    }
    
    private func setupAddProductsStub() {
        let url = EndpointManager.shared.getUrl(for: .AddProduct)!
        let jsonFile = CommonUnitTestsConstants.Stubs.getProductsSuccessResponse.rawValue
        stub.registerCustomStub(for: url, resource: jsonFile, status: .OK, isDown: false)
    }
    
    func testThatRetrievesProductsFromService() {
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
  
    func testThatAddsProductFromService() {
        let expectation = self.expectation(description: "AddProducts")
        var productList: [ProductEntity] = []
        addProductsUseCase.execute(title: "Tea", completion: { response in
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
    
    func testThatDeletesProductFromService() {
        let expectation = self.expectation(description: "DeleteProducts")
        var productList: [ProductEntity] = []
        deleteProductsUseCase.execute(id: "jrraq9ig", completion: { response in
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
