//
//  Product.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol ProductEntity: Codable {
    var id: String { get }
    var title: String { get }
    var count: Int { get set }
}

struct Product: ProductEntity {
    
    var id: String
    var title: String
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case count
    }
    
    init(id: String, title: String, count: Int) {
        self.id = id
        self.title = title
        self.count = count
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(String.self, forKey: .id)
            title = try values.decode(String.self, forKey: .title)
            count = try values.decode(Int.self, forKey: .count)
        } catch let jsonError {
            throw jsonError
        }
    }
}
