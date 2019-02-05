//
//  EndpointManager.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

enum Environment: String {
    case local
    case staging
    case production
    
    // TODO: Encode host urls in keychain for major security
    var host: String {
        switch self {
        case .local:
            return "http://localhost:3000"
        default:
            return ""
        }
    }
}

enum Endpoint: String {
    case AddProduct
    case DeleteProduct
    case DecrementCounter
    case IncrementCounter
    case GetProducts
    
    static let path: String = "Path"
    static let timeout: String = "Timeout"
    static let plistName: String = "Endpoints"
}

class EndpointManager {
    
    struct Constants {
        static let maxRetries: Int = 2
    }
    
    static let shared: EndpointManager = EndpointManager()
    
    var environment: Environment = .local
    var endpointDictionary: Dictionary<String, Any>?
    
    func getUrl(for endpoint: Endpoint, retries: Int = Constants.maxRetries) -> String? {
        guard retries > 0 else { return nil }
        
        guard let endpointsDictionary = endpointDictionary, !endpointsDictionary.isEmpty else {
            loadDictionary()
            return getUrl(for: endpoint, retries: retries - 1)
        }
        guard let endpointInfo = endpointsDictionary[endpoint.rawValue] as? Dictionary<String, Any>,
            let path = endpointInfo[Endpoint.path] as? String else { return nil }
        
        return environment.host + path
    }
    
    private func loadDictionary() {
        guard let path = Bundle.main.path(
                forResource: Endpoint.plistName,
                ofType: AppConstants.Extension.PLISTExtension) else {
                return
        }
        self.endpointDictionary = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any>
    }
    
}
