//
//  ProductListViewController.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

protocol ProductListViewProtocol: class {
    func showProducts(with products: [ProductViewModelProtocol])
}

class ProductListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ProductListPresenterProtocol?
    var productList = [ProductViewModelProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ProductListRouter.createProductListModule(productListRef: self)
        configureTableView()
        presenter?.viewDidLoad()
    }

}

// MARK: - ProductListViewProtocol

extension ProductListViewController: ProductListViewProtocol {
    
    func showProducts(with products: [ProductViewModelProtocol]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.productList = products
            self.tableView.reloadData()
            print(products)
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {

    private func configureTableView() {
        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let model = productList[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
}
