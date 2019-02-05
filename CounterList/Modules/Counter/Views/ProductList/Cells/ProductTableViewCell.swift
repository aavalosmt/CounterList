//
//  ProductTableViewCell.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/1/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

protocol ProductTableViewCellDelegate: class {
    func cellIncrement(id: String, count: Int)
    func cellDecrement(id: String, count: Int)
}

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCounterLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    // MARK: - Variables
    
    var id: String = ""
    var oldCounter: Int = 0
    weak var delegate: ProductTableViewCellDelegate?
    
    // MARK: - UITableViewCell LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTheme()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
    }
    
    // MARK: - Themeing
    
    private func configureTheme() {
        productNameLabel.font = UIFont(name: theme.fonts.regular, size: theme.fontSizes.label)
        productCounterLabel.font = UIFont(name: theme.fonts.bold, size: theme.fontSizes.label)
    }
    
    // MARK: - Data configuration
    
    func configure(with model: ProductViewModelProtocol) {
        id = model.id
        oldCounter = model.count
        
        productNameLabel.text = model.title
        productCounterLabel.text = String(model.count)
        stepper.value = Double(model.count)
    }
    
    // MARK: - IBActions
    
    @IBAction func stepperValueDidChange(_ sender: Any) {
        guard let sender = sender as? UIStepper else {
            return
        }
        let newValue = Int(sender.value)
        guard newValue >= 0 else {
            sender.value = 0
            return
        }
        if newValue < oldCounter {
            delegate?.cellDecrement(id: id, count: newValue)
        } else if newValue > oldCounter {
            delegate?.cellIncrement(id: id, count: newValue)
        }
    }
    
}
