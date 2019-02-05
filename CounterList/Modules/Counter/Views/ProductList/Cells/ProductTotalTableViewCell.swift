//
//  ProductTotalTableViewCell.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

class ProductTotalTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    // MARK: - UITableViewCell LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStrings()
        configureTheme()
    }
    
    // MARK: - Strings
    
    private func configureStrings() {
        totalLabel.text = "PRODUCT_LIST_CELL_TOTAL_TITLE".localized()
    }
    
    // MARK: - Themeing
    
    private func configureTheme() {
        totalLabel.font = UIFont(name: theme.fonts.regular, size: theme.fontSizes.label)
        counterLabel.font = UIFont(name: theme.fonts.bold, size: theme.fontSizes.label)
    }
    
    // MARK: - Data configuration
    
    func configure(with model: ProductTotalViewModelProtocol) {
        counterLabel.text = String(model.total)
    }
}
