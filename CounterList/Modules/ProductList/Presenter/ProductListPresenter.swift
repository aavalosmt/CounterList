//
//  ProductListPresenter.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol ProductListPresenterProtocol: class {
    var interactor: ProductListInputInteractorProtocol { get }
    var router: ProductListRouterProtocol { get }
    var view: ProductListViewProtocol? { get }
    
    func viewDidLoad()
    func deleteProduct(id: String)
    func incrementCounter(id: String, count: Int)
    func decrementCounter(id: String, count: Int)
    
    func showAddProduct()
}

class ProductListPresenter: ProductListPresenterProtocol {
    
    // MARK: - Dependencies
    
    let interactor: ProductListInputInteractorProtocol
    let router: ProductListRouterProtocol
    weak var view: ProductListViewProtocol?
    
    init(interactor: ProductListInputInteractorProtocol,
         router: ProductListRouterProtocol,
         view: ProductListViewProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
        interactor.presenter = self
    }
 
    func viewDidLoad() {
        loadProductList()
    }
    
    // MARK: - Interactor
    
    func loadProductList() {
        interactor.getProductList()
    }
    
    func deleteProduct(id: String) {
        interactor.deleteProduct(id: id)
    }
    
    func incrementCounter(id: String, count: Int) {
        interactor.incrementCounter(id: id, count: count)
    }
    
    func decrementCounter(id: String, count: Int) {
        interactor.decrementCounter(id: id, count: count)
    }
    
    func showAddProduct() {
        router.navigateToAddProductModule()
    }
    
}

// MARK: - AppListOutputInteractorProtocol

extension ProductListPresenter: ProductListOutputInteractorProtocol {

    func productListDidFetch(productList: [ProductViewModelProtocol]) {
        view?.showProducts(with: productList)
    }
    
    func productListDidFailed(with error: Error) {
        view?.showError(with: error)
    }
    
    func counterDidUpdate(id: String, products: [ProductViewModelProtocol]) {
        view?.didUpdateCounter(id: id, products: products)
    }
    
    func didDeleteProduct(productList: [ProductViewModelProtocol]) {
        view?.didDeleteProduct(products: productList)
    }
    
    func updateCounterDidFailed(id: String, error: Error) {
        
    }
    
}

