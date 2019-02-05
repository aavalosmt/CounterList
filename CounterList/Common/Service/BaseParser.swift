//
//  BaseParser.swift
//  ServiceLayer
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol ParserProtocol {
    associatedtype Model
    
    func parse(data: Data) -> Model?
}

open class BaseParser<Model: Codable>: ParserProtocol {
    
    public init() {}
    
    open func parse(data: Data) -> Model? {
        return jsonDecode(data: data)
    }
    
    open func parseJsonDictionary(fromData data: Data) -> Dictionary<String, Any>? {
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
            return jsonDictionary
        } catch {
            return nil
        }
    }
    
    open func jsonDecode(data: Data) -> Model? {
        let decodedModel = try? JSONDecoder().decode(Model.self, from: data)
        return decodedModel
    }
    
}

