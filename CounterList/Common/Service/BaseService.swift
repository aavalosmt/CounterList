//
//  BaseService.swift
//  ServiceLayer
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

public enum TimeOutInterval: Double {
    case oneMinute = 60.0
    case thirtySeconds = 30.0
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

public enum ServiceError: Int, Error {
    case parseError
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case unprocesableEntity = 422
    case serverError = 500
}

public enum ServiceResponse {
    case success(model: Codable)
    case failure(error: ServiceError)
}

public typealias ServiceResponseClosure = ((ServiceResponse) -> Void)

public protocol Service {
    
    var executionQueue: DispatchQueue { get set }
    
    func request(url: String,
                 method: RequestMethod,
                 parameters: Dictionary<String, Any>,
                 headers: Dictionary<String, String>,
                 completion: @escaping ServiceResponseClosure
        )
    
    func request(executionQueue: DispatchQueue,
                 url: String,
                 method: RequestMethod,
                 parameters: Dictionary<String, Any>,
                 headers: Dictionary<String, String>,
                 completion: @escaping ServiceResponseClosure
        )
    
    func processResponse(data: Data?,
                         urlResponse: HTTPURLResponse,
                         completion: @escaping ServiceResponseClosure)
}

open class BaseService<Model: Codable>: Service {
    
    private let configuration: URLSessionConfiguration
    private let cachePolicy: URLRequest.CachePolicy
    private let timeOut: TimeInterval
    
    public init(configuration: URLSessionConfiguration = .default,
         cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData,
         timeOut: TimeInterval = TimeOutInterval.thirtySeconds.rawValue) {
        self.configuration = configuration
        self.cachePolicy = cachePolicy
        self.timeOut = timeOut
    }
    
    public var executionQueue: DispatchQueue = .global(qos: .background)
    
    open func request(url: String, method: RequestMethod, parameters: Dictionary<String, Any>, headers: Dictionary<String, String>, completion: @escaping ServiceResponseClosure) {
        
        guard let url = URL(string: url) else {
            completion(.failure(error: ServiceError.badRequest))
            return
        }
        
        var request: URLRequest = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeOut)
        request.httpMethod = method.rawValue
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.allHTTPHeaderFields = headers
        
        executionQueue.async {
            let session: URLSession = URLSession(configuration: self.configuration)
            let task = session.dataTask(with: request) { (body, response, error) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    completion(.failure(error: ServiceError.badRequest))
                    return
                }
                self.processResponse(data: body, urlResponse: urlResponse, completion: completion)
            }
            task.resume()
        }
    }
    
    open func request(executionQueue: DispatchQueue, url: String, method: RequestMethod, parameters: Dictionary<String, Any>, headers: Dictionary<String, String>, completion: @escaping ServiceResponseClosure) {
        
        guard let url = URL(string: url) else {
            completion(.failure(error: ServiceError.badRequest))
            return
        }
        
        var request: URLRequest = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeOut)
        request.httpMethod = method.rawValue
        
        executionQueue.async {
            let session: URLSession = URLSession(configuration: self.configuration)
            let task = session.dataTask(with: request) { (body, response, error) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    completion(.failure(error: ServiceError.badRequest))
                    return
                }
                self.processResponse(data: body, urlResponse: urlResponse, completion: completion)
            }
            task.resume()
        }
    }
    
    open func parse(data: Data) -> Model? {
        return nil
    }
    
    open func processResponse(data: Data?, urlResponse: HTTPURLResponse, completion: @escaping ServiceResponseClosure) {
        guard let data = data else {
            completion(.failure(error: ServiceError.badRequest))
            return
        }
        switch urlResponse.statusCode {
        case 200:
            guard let model = parse(data: data) else {
                completion(.failure(error: ServiceError.parseError))
                return
            }
            completion(.success(model: model))
        default:
            guard let serviceError = ServiceError(rawValue: urlResponse.statusCode) else {
                completion(.failure(error: ServiceError.badRequest))
                return
            }
            completion(.failure(error: serviceError))
        }
    }
}
