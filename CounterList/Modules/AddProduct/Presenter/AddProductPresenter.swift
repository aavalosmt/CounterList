//
//  ProductDetailPresenter.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 8/3/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

protocol AddProductPresenterProtocol: class {
    var interactor: AddProductInputInteractorProtocol { get }
    var router: AddProductRouterProtocol { get }
    var view: AddProductViewProtocol? { get }
    
    func viewDidLoad()
    func addProduct(title: String)

    func cancelAddProduct()
}

class AddProductPresenter: AddProductPresenterProtocol {
    
    // MARK: - Dependencies
    
    let interactor: AddProductInputInteractorProtocol
    let router: AddProductRouterProtocol
    weak var view: AddProductViewProtocol?
    
    init(interactor: AddProductInputInteractorProtocol,
         router: AddProductRouterProtocol,
         view: AddProductViewProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
        interactor.presenter = self
    }
    
    func viewDidLoad() {
        
    }
    
    func addProduct(title: String) {
        interactor.addProduct(title: title)
    }
    
    func cancelAddProduct() {
        guard let view = view as? UIViewController else {
            return
        }
        
        view.navigationController?.popViewController(animated: true)
    }
}

extension AddProductPresenter: AddProductOutputInteractorProtocol {
    
    func addProductDidUpdate(products: [ProductListViewModelProtocol]) {
        router.didAddProduct(products: products)
    }
    
    func addProductDidFailed(error: Error) {
        
    }
    
}
