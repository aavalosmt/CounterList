//
//  Assembler.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/1/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol Assembler {
    associatedtype T
    associatedtype M
    
    // Facade
    func getObject(fromObject: T, type: T.Type) -> M?
}

