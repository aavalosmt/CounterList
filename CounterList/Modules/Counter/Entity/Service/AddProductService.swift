//
//  AddProductService.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol AddProductService {
    func addProduct(title: String, completion: @escaping ServiceResponseClosure)
}

class AddProductWebService: BaseService<[Product]>, AddProductService {
    
    enum Keys: String {
        case title
    }
    
    func addProduct(title: String, completion: @escaping ServiceResponseClosure) {
        guard let url = EndpointManager.shared.getUrl(for: .AddProduct) else {
            completion(.failure(error: ServiceError.badRequest))
            return
        }
        let contentType: ContentType = .applicationJson

        request(url: url,
                method: .post,
                parameters: [Keys.title.rawValue: title],
                headers: [contentType.key: contentType.value],
                completion: completion)
    }
    
    override func parse(data: Data) -> [Product]? {
        return BaseParser<[Product]>().parse(data: data)
    }
    
}
