//
//  GeneralTestsStubSetup.swift
//  CounterListTests
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation
import OHHTTPStubs

@testable import CounterList

enum statusCode: Int32 {
    case OK = 200
    case BadRequest = 400
    case UnauthorizedCode = 401
    case NoService = 501
    case UnprocessableEntity = 422
    case UnknowCode = 0
    case NoConection = -1009
    case NotFound = 404
}

class GeneralTestsStubSetup: StubSetup {
        
    override init() {
        super.init()
        self.endpointManager = EndpointManager.shared
        setup()
    }
    
    deinit {
        removeStubs()
    }
    
    /**
     Register a stub to simulate a succesfull scenario.
     
     - parameters:
     - endpoint: Endpoint in plist
     - resource: .json resource location
     - status: Response statusCode
     
     - Important:
     Make sure the resource is in the Mock folder and have the same name as the plist, if you need a custom mock just add the name in the resource param
     */
    func registerStubOk(for endpoint: Endpoint, resource: String? = nil, status: statusCode = .OK) {
        let urlStub = url(for: endpoint)
        let stubEndPoint = StubEndpoint(path: urlStub, resource: resource ?? endpoint.rawValue, status: status.rawValue)
        
        self.isDown = false
        registerStub(stubEndPoint)
    }
    
    /**
     Register a stub to simulate an empty Ok response.
     
     - parameters:
     - endpoint: Endpoint in plist
     */
    func registerStubEmptyOk(for endpoint: Endpoint) {
        let urlStub = url(for: endpoint)
        let stubEndPoint = StubEndpoint(path: urlStub, resource: CommonUnitTestsConstants.Resources.jsonSuccessResponse, status: statusCode.OK.rawValue)
        
        self.isDown = false
        registerStub(stubEndPoint)
    }
    
    /**
     Register a stub to simulate a bad request scenario.
     
     - parameters:
     - endpoint: Endpoint in plist
     - resource: .json resource location
     - status: Response statusCode
     
     - Important:
     Make sure the resource is in the Mock folder and have the same name as the plist, if you need a custom mock just add the name in the resource param
     */
    func registerStubBadRequest(for endpoint: Endpoint, resource: String? = nil, status: statusCode = .BadRequest) {
        let urlStub = url(for: endpoint)
        let stubEndPoint = StubEndpoint(path: urlStub, resource: resource ?? CommonUnitTestsConstants.Resources.jsonFailResponse, status: status.rawValue)
        
        self.isDown = false
        registerStub(stubEndPoint)
    }
    
    /**
     Register a stub to simulate a not connected scenario.
     
     - parameters:
     - endpoint: Endpoint in plist
     */
    func registerStubNotConnected(for endpoint: Endpoint) {
        let urlStub = url(for: endpoint)
        let stubEndPoint = StubEndpoint(path: urlStub, resource: "", status: statusCode.NoService.rawValue)
        
        self.isDown = true
        registerStub(stubEndPoint)
    }
    
    /**
     Register a stub with complex URL or path
     
     - parameters:
     - path: Full string endpoint
     - resource: .json rosource location
     - status: Status code
     
     - Important:
     Make sure the resource is in the Mock folder and have the same name as the plist, if you need a custom mock just add the name in the resource param
     */
    
    func registerCustomStub(for endpoint: String, resource: String, status: statusCode, isDown: Bool = false) {
        let stubEndPoint = StubEndpoint(path: endpoint, resource: resource, status: status.rawValue)
        self.isDown = isDown
        registerStub(stubEndPoint)
    }
    
    /**
     Register a stub with complex URL or path
     
     - parameters:
     - stubEndpoint: StubEndpoints.
     
     - Important:
     Make sure the resource is in the Mock folder and have the same name as the plist, if you need a custom mock just add the name in the resource param
     */
    
    func registerStubs(for stubEndpoints: StubEndpoint..., isDown: Bool = false) {
        self.isDown = isDown
        stubEndpoints.forEach { stubEndpoint in
            registerStub(stubEndpoint)
        }
    }
}
