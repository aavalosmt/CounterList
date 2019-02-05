//
//  String.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        let localizations = LocalizationManager.shared
        return localizations[self]
    }
}
