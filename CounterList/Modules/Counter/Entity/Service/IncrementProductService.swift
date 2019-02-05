//
//  IncrementProductService.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol IncrementProductService {
    func incrementProduct(id: String, completion: @escaping ServiceResponseClosure)
}

// Seems like backend service could be modified to receive the count and avoid incrementing or decrementing by 1
// If that was the case we could debounce the calls in presenter or interactor layer
// TODO: - Extend service layer to enqueue service calls in an operation queue maybe

class IncrementProductWebService: BaseService<[Product]>, IncrementProductService {
    
    enum Keys: String {
        case id
    }
    
    func incrementProduct(id: String, completion: @escaping ServiceResponseClosure) {
        guard let url = EndpointManager.shared.getUrl(for: .IncrementCounter) else {
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
