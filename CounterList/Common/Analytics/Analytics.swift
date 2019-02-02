//
//  Analytics.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/1/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

protocol AnalyticsProtocol {
    
    func trackScreen(screenName: String)
    func trackEvent(eventKey: String, eventName: String)
    
}

class Analytics: AnalyticsProtocol {
    
    func trackScreen(screenName: String) {
        
    }
    
    func trackEvent(eventKey: String, eventName: String) {
        
    }
    
}
