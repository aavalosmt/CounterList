//
//  ProductListInteractor.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol ProductListInputInteractorProtocol: class {
    var presenter: ProductListOutputInteractorProtocol? { get set }
    
    var addProductUseCase: AddProduct? { get }
    var getProductListUseCase: GetProductList? { get }
    var incrementProductCounterUseCase: IncrementProductCounter? { get }
    var decrementProductCounterUseCase: DecrementProductCounter? { get }
    var deleteProductUseCase: DeleteProduct? { get }
    
    //Presenter -> Interactor
    func getProductList()
    func addProduct(title: String)
    func incrementCounter(id: String, count: Int)
    func decrementCounter(id: String, count: Int)
    func deleteProduct(id: String)
}

protocol ProductListOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func productListDidFetch(productList: [ProductViewModelProtocol])
    func productListDidFailed(with error: Error)
    func counterDidUpdate(id: String, products: [ProductViewModelProtocol])
}

class ProductListInteractor: ProductListInputInteractorProtocol {
    
    weak var presenter: ProductListOutputInteractorProtocol?
    private let assembler: ProductViewModelAssembler<ProductEntity, ProductViewModel>
    
    var addProductUseCase: AddProduct?
    var getProductListUseCase: GetProductList?
    var incrementProductCounterUseCase: IncrementProductCounter?
    var decrementProductCounterUseCase: DecrementProductCounter?
    var deleteProductUseCase: DeleteProduct?
    
    init(addProductUseCase: AddProduct,
         getProductListUseCase: GetProductList,
         incrementProductCounterUseCase: IncrementProductCounter,
         decrementProductCounterUseCase: DecrementProductCounter,
         deleteProductUseCase: DeleteProduct,
         assembler: ProductViewModelAssembler<ProductEntity, ProductViewModel> = ProductViewModelAssembler<ProductEntity, ProductViewModel>()) {
        self.addProductUseCase = addProductUseCase
        self.getProductListUseCase = getProductListUseCase
        self.incrementProductCounterUseCase = incrementProductCounterUseCase
        self.decrementProductCounterUseCase = decrementProductCounterUseCase
        self.deleteProductUseCase = deleteProductUseCase
        self.assembler = assembler
    }
    
    func getProductList() {
        getProductListUseCase?.execute(usingCache: false, completion: {
            [weak self] response in
            guard let self = self else { return }
            self.handleProductResponse(response: response)
        })
    }
    
    func addProduct(title: String) {
        addProductUseCase?.execute(title: title) { [weak self] response in
            guard let self = self else { return }
            self.handleProductResponse(response: response)
        }
    }
    
    func incrementCounter(id: String, count: Int) {
        incrementProductCounterUseCase?.execute(id: id, completion: { [weak self, id] response in
            guard let self = self else { return }
            self.handleCounterResponse(response: response, id: id, count: count)
        })
    }
    
    func decrementCounter(id: String, count: Int) {
        decrementProductCounterUseCase?.execute(id: id, completion: { [weak self, id] response in
            guard let self = self else { return }
            self.handleCounterResponse(response: response, id: id, count: count)
        })
    }
    
    func deleteProduct(id: String) {
        deleteProductUseCase?.execute(id: id, completion: { [weak self] response in
            guard let self = self else { return }
            self.handleProductResponse(response: response)
        })
    }
    
    func handleCounterResponse(response: ProductListResponse, id: String, count: Int) {
        switch response {
        case .success(let products):
            let productList = products.compactMap({
                self.assembler.getObject(fromObject: $0, type: ProductEntity.self)
            }).sorted(by: { $0.title < $1.title })
            presenter?.counterDidUpdate(id: id, products: productList)
        case .failure(let error):
            presenter?.productListDidFailed(with: error)
        }
    }
    
    func handleProductResponse(response: ProductListResponse) {
        switch response {
        case .success(let products):
            let productList = products.compactMap({
                self.assembler.getObject(fromObject: $0, type: ProductEntity.self)
            }).sorted(by: { $0.title < $1.title })
            presenter?.productListDidFetch(productList: productList)
        case .failure(let error):
            presenter?.productListDidFailed(with: error)
        }
    }
}
