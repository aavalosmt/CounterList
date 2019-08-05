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
    
    var getProductListUseCase: GetProductList? { get }
    var deleteProductUseCase: DeleteProduct? { get }
    
    var incrementProductCounterUseCase: IncrementProductCounter? { get }
    var decrementProductCounterUseCase: DecrementProductCounter? { get }
    
    //Presenter -> Interactor
    func getProductList()
    func deleteProduct(id: String)
    func incrementCounter(id: String, count: Int)
    func decrementCounter(id: String, count: Int)
}

protocol ProductListOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func productListDidFetch(productList: [ProductViewModelProtocol])
    func productListDidFailed(with error: Error)
    func didDeleteProduct(productList: [ProductViewModelProtocol])
    
    func counterDidUpdate(id: String, products: [ProductViewModelProtocol])
    func updateCounterDidFailed(id: String, error: Error)
}

class ProductListInteractor: ProductListInputInteractorProtocol {
    
    weak var presenter: ProductListOutputInteractorProtocol?
    private let assembler: ProductViewModelAssembler<ProductEntity, ProductViewModel>
    
    var getProductListUseCase: GetProductList?
    var deleteProductUseCase: DeleteProduct?
    
    var incrementProductCounterUseCase: IncrementProductCounter?
    var decrementProductCounterUseCase: DecrementProductCounter?
    
    init(getProductListUseCase: GetProductList,
         deleteProductUseCase: DeleteProduct,
         incrementProductCounterUseCase: IncrementProductCounter,
         decrementProductCounterUseCase: DecrementProductCounter,
         assembler: ProductViewModelAssembler<ProductEntity, ProductViewModel> = ProductViewModelAssembler<ProductEntity, ProductViewModel>()) {
        self.getProductListUseCase = getProductListUseCase
        self.deleteProductUseCase = deleteProductUseCase
        self.incrementProductCounterUseCase = incrementProductCounterUseCase
        self.decrementProductCounterUseCase = decrementProductCounterUseCase
        self.assembler = assembler
    }
    
    func getProductList() {
        getProductListUseCase?.execute(usingCache: false, completion: {
            [weak self] response in
            guard let self = self else { return }
            self.handleProductResponse(response: response)
        })
    }
    
    func deleteProduct(id: String) {
        deleteProductUseCase?.execute(id: id, completion: { [weak self] response in
            guard let self = self else { return }
            self.handleDeleteResponse(response: response)
        })
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
    
    func handleCounterResponse(response: ProductListResponse, id: String, count: Int) {
        switch response {
        case .success(let products):
            let productList = products.compactMap({
                self.assembler.getObject(fromObject: $0, type: ProductEntity.self)
            }).sorted(by: { $0.title < $1.title })
            presenter?.counterDidUpdate(id: id, products: productList)
        case .failure(let error):
            presenter?.updateCounterDidFailed(id: id, error: error)
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
    
    func handleDeleteResponse(response: ProductListResponse) {
        switch response {
        case .success(let products):
            let productList = products.compactMap({
                self.assembler.getObject(fromObject: $0, type: ProductEntity.self)
            }).sorted(by: { $0.title < $1.title })
            presenter?.didDeleteProduct(productList: productList)
        case .failure(let error):
            presenter?.productListDidFailed(with: error)
        }
    }
    
}
