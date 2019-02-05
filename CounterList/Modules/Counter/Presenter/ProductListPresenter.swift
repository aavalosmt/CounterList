//
//  ProductListPresenter.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol ProductListPresenterProtocol: class {
    var interactor: ProductListInputInteractorProtocol? { get set }
    var view: ProductListViewProtocol? { get set }
    var router: ProductListRouterProtocol? { get set }
    
    func viewDidLoad()
    func addProduct(title: String)
    func deleteProduct(id: String)
    func incrementCounter(id: String)
    func decrementCounter(id: String)
}

class ProductListPresenter: ProductListPresenterProtocol {
    
    // MARK: - Dependencies
    
    var interactor: ProductListInputInteractorProtocol?
    var view: ProductListViewProtocol?
    weak var router: ProductListRouterProtocol?
    var presenter: ProductListPresenterProtocol?
    
    // MARK: - Constants
    
    let factory: ProductListViewModelFactory = ProductListViewModelFactory()
    
    struct Constants {
        static let debounceDelay: Double = 1.0
    }
        
    func viewDidLoad() {
        loadProductList()
    }
    
    // MARK: - Interactor
    
    func loadProductList() {
        interactor?.getProductList()
    }
    
    func addProduct(title: String) {
        interactor?.addProduct(title: title)
    }
    
    func deleteProduct(id: String) {
        interactor?.deleteProduct(id: id)
    }
    
    func incrementCounter(id: String) {
        interactor?.incrementCounter(id: id)
    }
    
    func decrementCounter(id: String) {
        interactor?.decrementCounter(id: id)
    }
    
}

// MARK: - AppListOutputInteractorProtocol

extension ProductListPresenter: ProductListOutputInteractorProtocol {
    
    func productListDidFetch(productList: [ProductViewModelProtocol]) {
        var viewModels = [ProductListViewModelProtocol]()
        viewModels.append(contentsOf: productList)
        factory.createModels(from: &viewModels)
        view?.showProducts(with: viewModels)
    }
    
    func productListDidFailed(with error: Error) {
        view?.showError(with: error)
    }
    
}

