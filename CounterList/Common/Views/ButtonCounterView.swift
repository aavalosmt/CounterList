//
//  ButtonCounterView.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 8/3/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

class ButtonCounterView: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    
    // MARK: - Variables
    
    var updateCounter: ((Int) -> Void)?
    var count: Int = 0 {
        didSet {
            counterLabel.text = String(self.count)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTheme()
    }
    
    private func configureTheme() {
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.backgroundColor = Theme.appTheme.colors.pallete.primary
        addButton.layer.cornerRadius = addButton.frame.size.height / 2.0
        addButton.clipsToBounds = true
        
        deleteButton.setTitleColor(UIColor.white, for: .normal)
        deleteButton.backgroundColor = Theme.appTheme.colors.pallete.primary
        deleteButton.layer.cornerRadius = deleteButton.frame.size.height / 2.0
        deleteButton.clipsToBounds = true
        
        incrementButton.setTitleColor(UIColor.white, for: .normal)
        incrementButton.backgroundColor = Theme.appTheme.colors.pallete.primary
        incrementButton.layer.cornerRadius = incrementButton.frame.size.height / 2.0
        incrementButton.clipsToBounds = true
        
        decrementButton.setTitleColor(UIColor.white, for: .normal)
        decrementButton.backgroundColor = Theme.appTheme.colors.pallete.primary
        decrementButton.layer.cornerRadius = decrementButton.frame.size.height / 2.0
        decrementButton.clipsToBounds = true
    }
    
    func configure(withCount count: Int) {
        self.count = count
        addButton.alpha = 1.0
        addButton.transform = CGAffineTransform.identity

        if count == 0 {
            deleteButton.alpha = 0.0
            incrementButton.alpha = 0.0
            decrementButton.alpha = 0.0
            counterLabel.alpha = 0.0
        } else {
            deleteButton.alpha = 1.0
            incrementButton.alpha = 1.0
            decrementButton.alpha = 1.0
            counterLabel.alpha = 1.0
            animateAdded()
        }
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        self.count = 1
        animateAdded()
        updateCounter?(self.count)
    }
    
    @IBAction func deleteButtonClick(_ sender: Any) {
        self.count = 0
        animateDeleted()
        updateCounter?(self.count)
    }
    
    @IBAction func incrementButtonClick(_ sender: Any) {
        self.count += 1
        updateCounter?(self.count)
    }
    
    @IBAction func decrementButtonClick(_ sender: Any) {
        guard self.count > 1 else {
            self.count = 1
            return
        }
        
        self.count -= 1
        updateCounter?(self.count)
    }
    
    private func animateAdded() {
        let animator = UIViewPropertyAnimator(duration: 0.4, curve: .linear) {
            self.deleteButton.alpha = 1.0
            self.incrementButton.alpha = 1.0
            self.decrementButton.alpha = 1.0
            self.counterLabel.alpha = 1.0
            self.addButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.deleteButton.transform = CGAffineTransform(translationX: 0.0, y: 15.0)
            self.incrementButton.transform = CGAffineTransform(translationX:30.0, y: 0.0)
            self.decrementButton.transform = CGAffineTransform(translationX: -30.0, y: 0.0)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.addButton.alpha = 0.0
        }, completion: { _ in
            animator.startAnimation()
        })
    }
    
    private func animateDeleted() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            self.addButton.alpha = 1.0
            self.deleteButton.alpha = 0.0
            self.incrementButton.alpha = 0.0
            self.decrementButton.alpha = 0.0
            self.counterLabel.alpha = 0.0
            self.addButton.transform = CGAffineTransform.identity
            self.deleteButton.transform = CGAffineTransform.identity
            self.incrementButton.transform = CGAffineTransform.identity
            self.decrementButton.transform = CGAffineTransform.identity
        }
        animator.startAnimation()
    }
    
}
