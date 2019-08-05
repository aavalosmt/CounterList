//
//  ProductCollectionViewCell.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 8/3/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var counterContainer: UIView!
    @IBOutlet weak var removeButton: UIButton!
    
    var counterView: ButtonCounterView?
    var model: ProductViewModelProtocol?
    
    var incrementCounter: ((String, Int) -> Void)?
    var decrementCounter: ((String, Int) -> Void)?
    var removeClosure: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButtonCounterView()
        clipsToBounds = true
        
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        
        productImage.clipsToBounds = true
        removeButton.backgroundColor = Theme.appTheme.colors.pallete.primary
    }
    
    private func configureButtonCounterView() {
        guard self.counterView == nil else {
            return
        }
        guard let counterView: ButtonCounterView = ButtonCounterView.fromNib() else {
            return
        }
        self.counterView = counterView
        counterContainer.addSubview(counterView)
        counterView.configureConstraintsToBorder(with: counterContainer)
        counterView.updateCounter = { [weak self] counter in
            guard let self = self else { return }
            self.updateCounter(newCounter: counter)
        }
    }

    func configure(withModel model: ProductViewModelProtocol, image: String) {
        self.model = model
        nameLabel.text = model.title
        counterView?.configure(withCount: model.count)
    
        productImage.image = UIImage(named: image)
    }
    
    private func updateCounter(newCounter: Int) {
        let id = model?.id ?? ""
        if newCounter > (model?.count ?? 0) {
            incrementCounter?(id, newCounter)
        } else {
            decrementCounter?(id, newCounter)
        }
        model?.count = newCounter
    }
    
    @IBAction func removeButtonClick(_ sender: Any) {
        let id = model?.id ?? ""
        removeClosure?(id)
    }
    
}
