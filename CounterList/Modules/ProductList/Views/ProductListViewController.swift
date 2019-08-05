//
//  ProductListViewController.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

protocol ProductListViewProtocol: class {
    func showProducts(with products: [ProductListViewModelProtocol])
    func showError(with error: Error)
    func didDeleteProduct(products: [ProductListViewModelProtocol])
    func didAddProduct(products: [ProductListViewModelProtocol])
    func didUpdateCounter(id: String, products: [ProductListViewModelProtocol])
}

class ProductListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var transitionPoint: CGPoint?
    
    var presenter: ProductListPresenterProtocol?
    var viewModels = [ProductListViewModelProtocol]()
    var indexInDeleteProcess: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func configureUI() {
        super.configureUI()
        view.backgroundColor = Theme.appTheme.colors.pallete.lightBackground
        
        configureCollectionView()
    }
    
    override func configureTheme() {
        super.configureTheme()
        addButton.backgroundColor = Theme.appTheme.colors.pallete.primary
    }
    
    @IBAction func addProductClick(_ sender: Any) {
        presenter?.showAddProduct()
    }
}

extension ProductListViewController: ProductListViewProtocol {
 
    func showProducts(with products: [ProductListViewModelProtocol]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.viewModels = products
            self.collectionView.reloadData()
        }
    }
    
    func showError(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.presentAlert(body: error.localizedDescription)
        }
    }
    
    func didAddProduct(products: [ProductListViewModelProtocol]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.viewModels = products
        }
    }
    
    func didUpdateCounter(id: String, products: [ProductListViewModelProtocol]) {
        self.viewModels = products
    }
    
    func didDeleteProduct(products: [ProductListViewModelProtocol]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.viewModels = products
            if self.indexInDeleteProcess >= 0 {
                self.collectionView.deleteItems(at: [IndexPath(item: self.indexInDeleteProcess, section: 0)])
            }
        }
    }
}

// MARK: UICollectionViewDelegate

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: addButton.frame.size.height, right: 0)
        
        collectionView.registerNib(identifier: ProductCollectionViewCell.identifier)
      
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        guard let model = viewModels[safe: indexPath.row] as? ProductViewModelProtocol else {
            return UICollectionViewCell()
        }
        
        cell.configure(withModel: model, image: ImageConstants.sampleImages[offset: indexPath.item] ?? "")
        
        cell.incrementCounter = { [weak self] id, count in
            guard let self = self else { return }
            self.presenter?.incrementCounter(id: id, count: count)
        }
        
        cell.decrementCounter = { [weak self] id, count in
            guard let self = self else { return }
            self.presenter?.decrementCounter(id: id, count: count)
        }
        
        cell.removeClosure = { [weak self] id in
            guard let self = self else { return }
            self.indexInDeleteProcess = self.viewModels.firstIndex(where: { ($0 as? ProductViewModelProtocol)?.id == id }) ?? -1
            self.presenter?.deleteProduct(id: id)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels.count
    }

}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2.0) - 5.0, height: 270.0)
    }
    
}

extension ProductListViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircularRevealTransitionAnimator(center: addButton.center)
    }
}
