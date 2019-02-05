//
//  ProductListRouter.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation
import UIKit

protocol ProductListRouterProtocol: class {
    static func createModule() -> UIViewController
}

class ProductListRouter: ProductListRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view = ProductListViewController()
        
        let interactor = ProductListInteractor(
            addProductUseCase: AddProductImpl(
                service: AddProductWebService()
            ),
            getProductListUseCase: GetProductListImpl(
                service: ProductListWebService()
            ),
            incrementProductCounterUseCase: IncrementProductCounterImpl(
                service: IncrementProductWebService()
            ),
            decrementProductCounterUseCase: DecrementProductCounterImpl(
                service: DecrementProductWebService()
            ),
            deleteProductUseCase: DeleteProductImpl(
                service: DeleteProductWebService()
            )
        )
        let router = ProductListRouter()
        
        let presenter: ProductListPresenterProtocol & ProductListOutputInteractorProtocol = ProductListPresenter(interactor: interactor, router: router, view: view)
        
        view.presenter = presenter
        
        return view
    }
    
}
