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

class IncrementProductWebService: BaseService<[Product]>, IncrementProductService {
    
    enum Keys: String {
        case id
    }
    
    func incrementProduct(id: String, completion: @escaping ServiceResponseClosure) {
        let url: String = "http://localhost:3000/api/v1/counter/inc"
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
