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
    static func createProductListModule(productListRef: ProductListViewController)
}

class ProductListRouter: ProductListRouterProtocol {
    
    static func createProductListModule(productListRef: ProductListViewController) {
        let presenter: ProductListPresenterProtocol & ProductListOutputInteractorProtocol = ProductListPresenter()
        
        productListRef.presenter = presenter
        productListRef.presenter?.router = ProductListRouter()
        productListRef.presenter?.view = productListRef
        productListRef.presenter?.interactor = ProductListInteractor(
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
        productListRef.presenter?.interactor?.presenter = presenter
    }
    
}
