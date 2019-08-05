//
//  ProductListRouter.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

protocol ProductListRouterProtocol: class {
    static func createModule() -> UIViewController
    
    func didAddProduct(products: [ProductListViewModelProtocol])
    func navigateToAddProductModule() 
}

class ProductListRouter: ProductListRouterProtocol {
    
    weak var view: ProductListViewProtocol?
    
    static func createModule() -> UIViewController {
        let view = ProductListViewController()
        
        let interactor = ProductListInteractor(
            getProductListUseCase: GetProductListImpl(
                service: ProductListWebService()
            ),
            deleteProductUseCase: DeleteProductImpl(
                service: DeleteProductWebService()
            ),
            incrementProductCounterUseCase: IncrementProductCounterImpl(
                service: IncrementProductWebService()
            ),
            decrementProductCounterUseCase: DecrementProductCounterImpl(
                service: DecrementProductWebService()
            )
        )
        let router = ProductListRouter()
        router.view = view
        
        let presenter: ProductListPresenterProtocol & ProductListOutputInteractorProtocol = ProductListPresenter(interactor: interactor, router: router, view: view)
        
        view.presenter = presenter
        
        return view
    }
    
    func navigateToAddProductModule() {
        guard let view = view as? UIViewController else {
            return
        }
        let module = AddProductRouter.createModule(fromRouter: self)
        view.navigationController?.pushViewController(module, animated: true)
    }
    
    func didAddProduct(products: [ProductListViewModelProtocol]) {
        view?.didAddProduct(products: products)
    }
    
}
