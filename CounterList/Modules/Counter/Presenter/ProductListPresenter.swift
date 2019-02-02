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
}

class ProductListPresenter: ProductListPresenterProtocol {
    var interactor: ProductListInputInteractorProtocol?
    var view: ProductListViewProtocol?
    weak var router: ProductListRouterProtocol?
    var presenter: ProductListPresenterProtocol?
    
    func viewDidLoad() {
        loadProductList()
    }
    
    func loadProductList() {
        interactor?.getProductList()
    }
}

// MARK: - AppListOutputInteractorProtocol

extension ProductListPresenter: ProductListOutputInteractorProtocol {
    
    func productListDidFetch(productList: [ProductViewModelProtocol]) {
        view?.showProducts(with: productList)
    }
    
}

