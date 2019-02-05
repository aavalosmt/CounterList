//
//  ProductListViewController.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

protocol ProductListViewProtocol: class {
    func showProducts(with products: [ProductListViewModelProtocol], indices: [Int])
    func showError(with error: Error)
    func didUpdateCounter(id: String, products: [ProductListViewModelProtocol])
}

class ProductListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ProductListPresenterProtocol?
    var viewModels = [ProductListViewModelProtocol]()
    
    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private func reloadTotalCell() {
        guard let index = viewModels.firstIndex(where: { $0.type == .total }),
              let model = viewModels[index] as? ProductTotalViewModelProtocol else { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        
        DispatchQueue.main.async { [weak self, model] in
            guard let self = self else { return }
            guard let visibleCellPaths = self.tableView.indexPathsForVisibleRows else { return }
            if visibleCellPaths.contains(indexPath),
               let cell = self.tableView.cellForRow(at: indexPath) as? ProductTotalTableViewCell {
                cell.configure(with: model)
            }
        }
    }
}

// MARK: - ProductListViewProtocol

extension ProductListViewController: ProductListViewProtocol {
    
    func showProducts(with products: [ProductListViewModelProtocol], indices: [Int]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let oldCount = self.viewModels.count
            let indices = indices.map({ IndexPath(row: $0, section: 0) })
            self.viewModels = products
            if oldCount < products.count {
                self.tableView.insertRows(at: indices, with: .automatic)
            } else if oldCount > products.count {
                self.tableView.deleteRows(at: indices, with: .automatic)
            } else {
                self.tableView.reloadData()
            }
            self.reloadTotalCell()
        }
    }
    
    func showError(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.presentAlert(body: error.localizedDescription)
        }
    }
    
    func didUpdateCounter(id: String, products: [ProductListViewModelProtocol]) {
        guard let index = viewModels.compactMap({ $0 as? ProductViewModelProtocol }).firstIndex(where: { $0.id == id }),
              let totalIndex = viewModels.firstIndex(where: { $0.type == .total }) else { return }
        self.viewModels = products
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let visibleCellPaths = self.tableView.indexPathsForVisibleRows else { return }
            if visibleCellPaths.contains(IndexPath(row: index, section: 0)) {
                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0), IndexPath(row: totalIndex, section: 0)], with: .none)
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {

    private func configureTableView() {
        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(UINib(nibName: ProductTotalTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTotalTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModels[indexPath.row]
        switch model.type {
        case .product:
            return getProductTableViewCell(tableView, indexPath: indexPath)
        case .total:
            return getTotalTableViewCell(tableView, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let model = viewModels[indexPath.row]
        switch model.type {
        case .total:
            return []
        case .product:
            let delete = UITableViewRowAction(style: .destructive, title: "PRODUCT_LIST_CELL_ACTION_DELETE".localized()) { (action, indexPath) in
                guard let product = self.viewModels[indexPath.row] as? ProductViewModelProtocol else { return }
                self.presenter?.deleteProduct(id: product.id)
            }
            return [delete]
        }
    }
    
    private func getProductTableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell,
               let model = viewModels[indexPath.row] as? ProductViewModelProtocol else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    private func getTotalTableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTotalTableViewCell.identifier) as? ProductTotalTableViewCell,
              let model = viewModels[indexPath.row] as? ProductTotalViewModelProtocol else {
                return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
}

// MARK: - ProductTableViewCellDelegate

extension ProductListViewController: ProductTableViewCellDelegate {
    
    func cellIncrement(id: String, count: Int) {
        presenter?.incrementCounter(id: id, count: count)
    }
    
    func cellDecrement(id: String, count: Int) {
        presenter?.decrementCounter(id: id, count: count)
    }
    
}
