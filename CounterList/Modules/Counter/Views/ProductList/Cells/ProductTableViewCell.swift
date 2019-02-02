//
//  ProductTableViewCell.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/1/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCounterLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    // MARK: - UITableViewCell LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTheme()
    }
    
    // MARK: - Themeing
    
    private func configureTheme() {
        productNameLabel.font = UIFont(name: theme.fonts.regular, size: theme.fontSizes.label)
        productCounterLabel.font = UIFont(name: theme.fonts.bold, size: theme.fontSizes.label)
    }
    
    // MARK: - Data configuration
    
    func configure(with model: ProductViewModelProtocol) {
        productNameLabel.text = model.title
        productCounterLabel.text = String(model.count)
    }
    
}
