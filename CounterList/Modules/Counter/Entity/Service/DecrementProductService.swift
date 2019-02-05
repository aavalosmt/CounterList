//
//  DecrementProductService.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol DecrementProductService {
    func decrementProduct(id: String, completion: @escaping ServiceResponseClosure)
}

class DecrementProductWebService: BaseService<[Product]>, DecrementProductService {
    
    enum Keys: String {
        case id
    }
    
    func decrementProduct(id: String, completion: @escaping ServiceResponseClosure) {
        guard let url = EndpointManager.shared.getUrl(for: .DecrementCounter) else {
            completion(.failure(error: ServiceError.badRequest))
            return
        }
        let contentType: ContentType = .applicationJson
        
        request(url: url,
                method: .post,
                parameters: [Keys.id.rawValue: id],
                headers: [contentType.key: contentType.value],
                completion: completion)
    }
    
    override func parse(data: Data) -> [Product]? {
        return BaseParser<[Product]>().parse(data: data)
    }
}
