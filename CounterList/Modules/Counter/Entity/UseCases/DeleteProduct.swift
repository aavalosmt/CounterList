//
//  DeleteProduct.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol DeleteProduct {
    func execute(id: String, completion: @escaping (ProductListResponse) -> Void)
}

class DeleteProductImpl: DeleteProduct {
    
    let service: DeleteProductService
    
    init(service: DeleteProductService) {
        self.service = service
    }
    
    func execute(id: String, completion: @escaping (ProductListResponse) -> Void) {
        service.delete(id: id) { response in
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
