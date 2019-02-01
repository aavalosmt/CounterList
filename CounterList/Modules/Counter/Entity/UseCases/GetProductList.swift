//
//  GetProductList.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation
import ServiceLayer

enum ProductListResponse {
    case success(products: [Product])
    case failure(error: Error)
}

protocol GetProductList {
    var service: ProductListService { get }
    func getProductList(usingCache: Bool, completion: @escaping (ProductListResponse) -> Void)
}

class GetProductListImpl: GetProductList {
    
    let service: ProductListService
    
    init(service: ProductListService) {
        self.service = service
    }
    
    func getProductList(usingCache: Bool, completion: @escaping (ProductListResponse) -> Void) {
        if usingCache {
            
        } else {
            getProductListFromService(completion: completion)
        }
    }
    
    private func getProductListFromService(completion: @escaping (ProductListResponse) -> Void) {
        service.getProductList { response in
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
