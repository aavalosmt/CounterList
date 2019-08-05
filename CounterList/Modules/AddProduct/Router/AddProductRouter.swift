//
//  ProductDetailRouter.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 8/3/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

protocol AddProductRouterProtocol: class {
    static func createModule(fromRouter router: ProductListRouterProtocol) -> UIViewController
    
    func didAddProduct(products: [ProductListViewModelProtocol])
}

class AddProductRouter: AddProductRouterProtocol {
    
    weak var previousRouter: ProductListRouterProtocol?
    weak var view: AddProductViewProtocol?
    
    static func createModule(fromRouter router: ProductListRouterProtocol) -> UIViewController {
        let view = AddProductViewController()
        
        let interactor = AddProductInteractor(
            addProductUseCase: AddProductImpl(
                service: AddProductWebService()
            )
        )
        let addProductRouter = AddProductRouter()
        addProductRouter.previousRouter = router
        addProductRouter.view = view
        
        let presenter: AddProductPresenterProtocol & AddProductOutputInteractorProtocol = AddProductPresenter(interactor: interactor, router: addProductRouter, view: view)
        
        view.presenter = presenter
        
        return view
    }
    
    func didAddProduct(products: [ProductListViewModelProtocol]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let view = self.view as? UIViewController else {
                return
            }
            view.navigationController?.popViewController(animated: true)
            self.previousRouter?.didAddProduct(products: products)
        }
    }
    
}
