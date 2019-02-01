//
//  ProductListViewController.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

protocol ProductListViewProtocol: class {
    func showProducts(with products: [ProductEntity])
}

class ProductListViewController: UIViewController {
    
    var presenter: ProductListPresenterProtocol?
    var productList = [ProductEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ProductListRouter.createProductListModule(productListRef: self)
        presenter?.viewDidLoad()
    }

}

extension ProductListViewController: ProductListViewProtocol {
    
    func showProducts(with products: [ProductEntity]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.productList = products
            print(products)
        }
    }
    
}
