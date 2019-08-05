//
//  ProductDetailInteractor.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 8/3/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol AddProductInputInteractorProtocol: class {
    var presenter: AddProductOutputInteractorProtocol? { get set }
    var addProductUseCase: AddProduct? { get }
    
    func addProduct(title: String)
}

protocol AddProductOutputInteractorProtocol: class {
    func addProductDidUpdate(products: [ProductListViewModelProtocol])
    func addProductDidFailed(error: Error)
}

class AddProductInteractor: AddProductInputInteractorProtocol {
    
    weak var presenter: AddProductOutputInteractorProtocol?
    private let assembler: ProductViewModelAssembler<ProductEntity, ProductViewModel>

    var addProductUseCase: AddProduct?
    
    init(addProductUseCase: AddProduct,
         assembler: ProductViewModelAssembler<ProductEntity, ProductViewModel> = ProductViewModelAssembler<ProductEntity, ProductViewModel>()) {
        self.addProductUseCase = addProductUseCase
        self.assembler = assembler
    }

    func addProduct(title: String) {
        addProductUseCase?.execute(title: title) { [weak self] response in
            guard let self = self else { return }
            self.handleAddProductResponse(response: response)
        }
    }
    
    func handleAddProductResponse(response: ProductListResponse) {
        switch response {
        case .success(let products):
            let productList = products.compactMap({
                self.assembler.getObject(fromObject: $0, type: ProductEntity.self)
            }).sorted(by: { $0.title < $1.title })
            presenter?.addProductDidUpdate(products: productList)
        case .failure(let error):
            presenter?.addProductDidFailed(error: error)
        }
    }
}
