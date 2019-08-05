//
//  BaseViewController.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/1/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureUI() {
        configureTheme()
    }
    
    func configureTheme() {
        
    }
    
    func presentAlert(title: String = "ALERT_TITLE".localized(),
                      body: String,
                      ctaTitle: String = "ALERT_OK_CTA_TITLE".localized(),
                      completion: (@escaping () -> Void) = { return }) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: ctaTitle, style: .default))
        present(alert, animated: true, completion: completion)
    }
    
    func presentAlertController(title: String,
                                description: String,
                                textFieldTitle: String,
                                completion: @escaping (String?) -> Void,
                                cancelationHandler: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = textFieldTitle
        }
        
        alert.addAction(UIAlertAction(title: "ALERT_CANCEL_CTA_TITLE".localized(), style: .default, handler: { [weak alert] _ in
            alert?.dismiss(animated: true, completion: cancelationHandler)
        }))
        
        alert.addAction(UIAlertAction(title: "ALERT_ACCEPT_CTA_TITLE".localized(), style: .default, handler: { [weak alert] _ in
            let textFieldText = alert?.textFields?.first?.text
            completion(textFieldText)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}
