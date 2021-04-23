//
//  ProductsViewController.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit

class ProductsViewController: UIViewController, ProductsViewProtocol {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subcategoryCollectionView: UICollectionView!
    @IBOutlet private weak var productsTableView: UITableView!
    @IBOutlet private weak var emptyStateView: UIMLEmptyStateView!
    @IBOutlet private weak var houseButton: UIButton!
    
    // MARK: - PROPERTIES.
    var viewModel: ProductsViewModelProtocol?
    private var numberOfSubcategories = 0
    private var numberOfProducts = 0
    private typealias constants = GeneralConstants

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setup()
        presentLoader { [weak self] in
            self?.viewModel?.didLoad()
        }
    }
    
    // MARK: - SETUP.
    private func setup() {
        bind()
        setupTableView()
        setupCollectionView()
        
        titleLabel.text = ""
        houseButton.isHidden = true
        emptyStateView.isHidden = true
        emptyStateView.hiddeButton = true
    }
    
    private func setupTableView() {
        productsTableView.isHidden = true
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.rowHeight = UITableView.automaticDimension
        productsTableView.estimatedRowHeight = constants.estimatedRowHeight
        productsTableView.register(ProductViewCell.nib,
                                   forCellReuseIdentifier: ProductViewCell.reuseIdentifier)
    }
    
    private func setupCollectionView() {
        subcategoryCollectionView.isHidden = true
        subcategoryCollectionView.delegate = self
        subcategoryCollectionView.dataSource = self
        subcategoryCollectionView.register(SubcategoryViewCell.nib,
                                           forCellWithReuseIdentifier: SubcategoryViewCell.reuseIdentifier)
        if let flowLayout = subcategoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = constants.subcategoryLineSpace
        }
    }
    
    private func bind() {
        self.viewModel?.reloadTableView = ({ [weak self] numberOfItems in
            self?.numberOfProducts = numberOfItems
            self?.productsTableView.isHidden = false
            self?.productsTableView.reloadData()
            self?.dismissLoader(completion: nil)
        })
        
        self.viewModel?.reloadCollectionView = ({ [weak self] numberOfItems in
            self?.numberOfSubcategories = numberOfItems
            self?.subcategoryCollectionView.isHidden = false
            self?.subcategoryCollectionView.reloadData()
        })
        
        self.viewModel?.updateEmptyState = ({ [weak self] showEmptyState, message, image in
            self?.emptyStateView.message = message
            self?.emptyStateView.errorImage = image
            self?.emptyStateView.isHidden = false
            self?.dismissLoader(completion: nil)
        })
        
        self.viewModel?.pushView = ({ [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        })
        
        self.viewModel?.updateTitle = ({ [weak self] title in
            self?.titleLabel.text = title
        })
        
        self.viewModel?.showHouseButton = ({ [weak self] isVisible in
            self?.houseButton.isHidden = !isVisible
        })
    }
    
    // MARK: - IBACTIONS.
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func houseAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UITABLEVIEWDELEGATE & UITABLEVIEWDAATASOURCE IMPLEMENTATION.
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel?.getCellModel(at: indexPath.item, isSubcategory: false) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier, for: indexPath)
        
        (cell as? ViewCellConfigurable)?.setup(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.didSelect(at: indexPath.item, isSubcategory: false)
    }
}

// MARK: -UICOLLECTIONVIEWDELEGATE & UICOLLECTIONVIEWDATASOURCE IMPLEMENTATION.
extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfSubcategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = self.viewModel?.getCellModel(at: indexPath.item, isSubcategory: true) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reuseIdentifier, for: indexPath)
        
        (cell as? ViewCellConfigurable)?.setup(model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelect(at: indexPath.item, isSubcategory: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return constants.subcategoryCellSize
    }
}
