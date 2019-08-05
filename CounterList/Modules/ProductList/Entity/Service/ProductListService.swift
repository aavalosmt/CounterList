//
//  ProductListService.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol ProductListService {
    func getProductList(completion: @escaping ServiceResponseClosure)
}

class ProductListWebService: BaseService<[Product]>, ProductListService {
    
    func getProductList(completion: @escaping ServiceResponseClosure) {
        guard let url = EndpointManager.shared.getUrl(for: .GetProducts) else {
            completion(.failure(error: ServiceError.badRequest))
            return
        }
        request(url: url,
                method: .get,
                parameters: [:],
                headers: [:],
                completion: completion)
    }
    
    override func parse(data: Data) -> [Product]? {
        return BaseParser<[Product]>().parse(data: data)
    }
    
}
