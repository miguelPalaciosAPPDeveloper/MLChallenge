//
//  ProductsViewProtocols.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

// MARK: - CELL VIEWMODEL
protocol ProductCellViewModelProtocol: class {
    var updatePrice: ((String) -> Void)? { get set }
    var updateOffText: ((String) -> Void)? { get set }
    var productImage: ((UIImage?) -> Void)? { get set }
    var updateShipping: ((String) -> Void)? { get set }
    var updateInstallments: ((String) -> Void)? { get set }
    
    func downloadImage(thumbnail: String)
    
    func setupCell(product: MLProduct, savedCurrencyID: String)
}

// MARK: - VIEW.
protocol ProductsViewProtocol: LoaderPresentable {
    var viewModel: ProductsViewModelProtocol? { get set }
}

// MARK: - PRODUCTVIEWMODEL.
protocol ProductsViewModelProtocol: class {
    var updateTitle: ((String) -> Void)? { get set }
    var reloadTableView: ((Int) -> Void)? { get set }
    var showHouseButton: ((Bool) -> Void)? { get set }
    var reloadCollectionView: ((Int) -> Void)? { get set }
    var pushView: ((UIViewController) -> Void)? { get set }
    var updateEmptyState: ((Bool, String, UIImage?) -> Void)? { get set }
    
    func didLoad()
    
    func getCellModel(at index: Int, isSubcategory: Bool) -> ViewCellModel
    
    func didSelect(at index: Int, isSubcategory: Bool)
}
