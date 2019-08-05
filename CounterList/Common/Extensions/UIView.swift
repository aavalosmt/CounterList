//
//  UIView.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/1/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

extension UIView {
    
    var theme: ThemeProtocol {
        return Theme.appTheme
    }
    
    class func fromNib<T: UIView>(fileName: String? = nil) -> T? {
        let className = fileName ?? String(describing: T.self)
        let nibFile = UINib(nibName: className, bundle: nil)
        let view = nibFile.instantiate(withOwner: self, options: nil).first
       
        return view as? T
    }
    
    func configureConstraintsToBorder(with view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
}
