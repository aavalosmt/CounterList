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
    var useCase: GetProductList? { get set }

    //Presenter -> Interactor
    func getProductList()
}

protocol ProductListOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func productListDidFetch(productList: [Product])
}

class ProductListInteractor: ProductListInputInteractorProtocol {
    
    weak var presenter: ProductListOutputInteractorProtocol?
    var useCase: GetProductList?
    
    init(useCase: GetProductList) {
        self.useCase = useCase
    }
    
    func getProductList() {
        useCase?.getProductList(usingCache: false, completion: {
            [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let products):
                self.presenter?.productListDidFetch(productList: products)
            case .failure(let error):
                print(error)
            }
        })
    }
}
