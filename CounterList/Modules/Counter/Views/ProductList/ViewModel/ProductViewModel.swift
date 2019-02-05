//
//  ProductViewModel.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/1/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

enum ProductListViewModelType {
    case product
    case total
}

protocol ProductListViewModelProtocol {
    var type: ProductListViewModelType { get }
}

protocol ProductViewModelProtocol: ProductListViewModelProtocol {
    var id: String { get }
    var title: String { get }
    var count: Int { get }
}

// Class for representing displayable data apart from the ProductEntity which is a Model Layer entity
// Even as an entity might have the exact same code as another one, this should be considered coincidence, as their reason to change are completely different (Single responsibility principle).

struct ProductViewModel: ProductViewModelProtocol {
    var type: ProductListViewModelType
    var id: String
    var title: String
    var count: Int
}

// Generates ProductViewModelProtocol object from different object types

struct ProductViewModelAssembler<T, M: ProductViewModelProtocol>: Assembler {
    
    func getObject(fromObject object: T, type: T.Type) -> M? {
        switch String(describing: type) {
        case String(describing: ProductEntity.self):
            guard let product = object as? ProductEntity else { return nil }
            return ProductViewModel(type: .product, id: product.id, title: product.title, count: product.count) as? M
        default:
            return nil
        }
    }
    
}





