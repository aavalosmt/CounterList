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
    func showError(with error: Error)
}

class ProductListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ProductListPresenterProtocol?
    var productList = [ProductViewModelProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ProductListRouter.createProductListModule(productListRef: self)
        presenter?.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        title = "PRODUCT_LIST_TITLE".localized()
        addBarButtonItem()
        configureTableView()
    }
    
    private func addBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "PRODUCT_LIST_BAR_ACTION_ADD".localized(), style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        presentAlertController(
            title: "PRODUCT_LIST_ALERT_ADD_TITLE".localized(),
            description: "PRODUCT_LIST_ALERT_ADD_DESCRIPTION".localized(),
            textFieldTitle: "PRODUCT_LIST_ALERT_ADD_TEXTFIELD".localized(),
            completion: { [weak self] name in
                guard let self = self else { return }
                self.addProduct(name: name)
            },
            cancelationHandler: nil
        )
    }
    
    private func addProduct(name: String?) {
        guard let name = name, !name.isEmpty else { return }
        presenter?.addProduct(title: name)
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
    
    func showError(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.presentAlert(body: error.localizedDescription)
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
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "PRODUCT_LIST_CELL_ACTION_DELETE".localized()) { (action, indexPath) in
            let product = self.productList[indexPath.row]
            self.presenter?.deleteProduct(id: product.id)
        }
        return [delete]
    }
}

// MARK: - ProductTableViewCellDelegate

extension ProductListViewController: ProductTableViewCellDelegate {
    
    func didIncrement(id: String) {
        presenter?.incrementCounter(id: id)
    }
    
    func didDecrement(id: String) {
        presenter?.decrementCounter(id: id)
    }
    
}
