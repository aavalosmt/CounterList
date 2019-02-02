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
    func productListDidFetch(productList: [ProductViewModelProtocol])
}

class ProductListInteractor: ProductListInputInteractorProtocol {
    
    weak var presenter: ProductListOutputInteractorProtocol?
    private let assembler: ProductViewModelAssembler<ProductEntity, ProductViewModel>
    var useCase: GetProductList?
    
    init(useCase: GetProductList,
         assembler: ProductViewModelAssembler<ProductEntity, ProductViewModel> = ProductViewModelAssembler<ProductEntity, ProductViewModel>()) {
        self.useCase = useCase
        self.assembler = assembler
    }
    
    func getProductList() {
        useCase?.getProductList(usingCache: false, completion: {
            [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let products):
                let productList = products.compactMap({
                    self.assembler.getObject(fromObject: $0, type: ProductEntity.self)
                })
                self.presenter?.productListDidFetch(productList: productList)
            case .failure(let error):
                print(error)
            }
        })
    }
}
