//
//  AddProductViewController.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 8/3/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol AddProductViewProtocol: class {
    func didAddProduct()
}

class AddProductViewController: BaseViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var floatingTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet var textFieldCenterYLayoutConstraint: NSLayoutConstraint?
    
    var presenter: AddProductPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(
                self.keyboardNotification(notification:)
            ),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    override func configureUI() {
        super.configureUI()
        
        floatingTextField.placeholder = "Product name"
        floatingTextField.title = "Product name"
        floatingTextField.tintColor = Theme.appTheme.colors.pallete.primary
        floatingTextField.selectedIconColor = Theme.appTheme.colors.pallete.primary
        floatingTextField.selectedTitleColor = Theme.appTheme.colors.pallete.primary
        floatingTextField.selectedLineColor = Theme.appTheme.colors.pallete.primary
        floatingTextField.iconText = "\u{f0d8}"
    }
    
    override func configureTheme() {
        super.configureTheme()
        closeButton.layer.cornerRadius = closeButton.frame.size.height / 2.0
        closeButton.clipsToBounds = true
        closeButton.backgroundColor = Theme.appTheme.colors.pallete.primary
        
        confirmButton.backgroundColor = Theme.appTheme.colors.pallete.primary
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        presenter?.cancelAddProduct()
    }
    
    @IBAction func confirmButtonClick(_ sender: Any) {
        guard let title = floatingTextField.text else {
            return
        }
        presenter?.addProduct(title: title)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
                self.textFieldCenterYLayoutConstraint?.constant = 0.0
            } else {
                self.textFieldCenterYLayoutConstraint?.constant = -70.0
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}

extension AddProductViewController: AddProductViewProtocol {
    
    func didAddProduct() {
        
    }
    
}

