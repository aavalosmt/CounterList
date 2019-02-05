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
    func addProduct(title: String)
    func deleteProduct(id: String)
    func incrementCounter(id: String, count: Int)
    func decrementCounter(id: String, count: Int)
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

    
    // MARK: - Constants
    
    let factory: ProductListViewModelFactory = ProductListViewModelFactory()
    var oldViewModels: [ProductViewModelProtocol] = []
    
    struct Constants {
        static let debounceDelay: Double = 1.0
    }
        
    func viewDidLoad() {
        loadProductList()
    }
    
    // MARK: - Interactor
    
    func loadProductList() {
        interactor.getProductList()
    }
    
    func addProduct(title: String) {
        interactor.addProduct(title: title)
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
    
}

// MARK: - AppListOutputInteractorProtocol

extension ProductListPresenter: ProductListOutputInteractorProtocol {
    
    func productListDidFetch(productList: [ProductViewModelProtocol]) {
        var viewModels = [ProductListViewModelProtocol]()
        viewModels.append(contentsOf: productList)
        factory.createModels(from: &viewModels)
        
        guard !oldViewModels.isEmpty else {
            view?.showProducts(with: viewModels, indices: Array(0..<viewModels.count))
            oldViewModels = productList
            return 
        }
        
        var updatedIndices: [Int] = []
        // Insert
        if oldViewModels.count < productList.count {
            updatedIndices = productList.map({ $0.id }).addedIndices(oldArray: oldViewModels.map({ $0.id }))
        } else {
            // Delete
            updatedIndices = oldViewModels.map({ $0.id }).addedIndices(oldArray: productList.map({ $0.id }))
        }
        
        // Telling the view which indexes where updated
        view?.showProducts(with: viewModels, indices: updatedIndices)
        oldViewModels = productList
    }
    
    func productListDidFailed(with error: Error) {
        view?.showError(with: error)
    }
    
    func counterDidUpdate(id: String, count: Int) {
        view?.didUpdateCounter(id: id, count: count)
    }
    
}

