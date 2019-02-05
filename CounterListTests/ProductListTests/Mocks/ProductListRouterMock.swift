//
//  ProductListRouterMock.swift
//  CounterListTests
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit
@testable import CounterList

class ProductListRouterMock: ProductListRouterProtocol {
    
    static func createModule() -> UIViewController {
        return UIViewController()
    }
    
}
