//
//  AddProduct.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol AddProduct {
    func execute(title: String, completion: @escaping (ProductListResponse) -> Void)
}

class AddProductImpl: AddProduct {
    
    let service: AddProductService
    
    init(service: AddProductService) {
        self.service = service
    }
    
    func execute(title: String, completion: @escaping (ProductListResponse) -> Void) {
        service.addProduct(title: title) { response in
            switch response {
            case .success(let productList):
                guard let productList = productList as? [Product] else {
                    completion(.failure(error: ServiceError.parseError))
                    return
                }
                completion(.success(products: productList))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
}
