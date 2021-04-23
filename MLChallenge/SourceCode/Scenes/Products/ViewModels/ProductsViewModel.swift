//
//  ProductsViewModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

class ProductsViewModel {
    // MARK: - PROPERTIES.
    var updateTitle: ((String) -> Void)?
    var reloadTableView: ((Int) -> Void)?
    var showHouseButton: ((Bool) -> Void)?
    var reloadCollectionView: ((Int) -> Void)?
    var pushView: ((UIViewController) -> Void)?
    var updateEmptyState: ((Bool, String, UIImage?) -> Void)?
    
    private var productsCells: [ProductViewCellModel] = []
    private var subcategories: [SubcategoryViewCellModel] = []
    private let builder = ProductsBuilder()
    private let productServiceManager: ProductsServiceManager
    private let categoriesServiceManager: CategoriesServiceManager
    private let userDefaultsManager = UserDefaultsManager()
    private let productQuery: String?
    private let category: MLCategory?
    private let isFromProducts: Bool
    private var siteId = ""
    private var savedCurrencyID: String
    
    init(productServiceManager: ProductsServiceManager,
         categoriesServiceManager: CategoriesServiceManager,
         productQuery: String?,
         category: MLCategory?,
         savedCurrencyID: String,
         isFromProducts: Bool) {
        self.categoriesServiceManager = categoriesServiceManager
        self.productServiceManager = productServiceManager
        self.productQuery = productQuery
        self.category = category
        self.savedCurrencyID = savedCurrencyID
        self.isFromProducts = isFromProducts
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    private func getSubcategories() {
        guard let mainCategory = category else {
            getProductsByQuery()
            return
        }
        
        updateTitle?(mainCategory.name)
        
        categoriesServiceManager.getSubcategories(category: mainCategory.id) { [weak self] (result, _, _) in
            switch result {
            case .success(let response):
                self?.updateSubcategoriesCells(categories: response.childrenCategories)
                self?.getProductsByCategory(mainCategory: mainCategory.id)
            case .failure:
                self?.getProductsByCategory(mainCategory: mainCategory.id)
            }
        }
    }
    
    private func getProductsByQuery() {
        guard let query = productQuery else { return }
        let text = query.replacingOccurrences(of: "+", with: " ")
        updateTitle?(text)
        
        productServiceManager.getProductsBy(query: query, site: siteId) { [weak self] (result, _, _) in
            switch result {
            case .success(let response):
                self?.updateProductCells(products: response.products)
            case .failure(let error):
                self?.showEmptyState(error: error)
            }
        }
    }
    
    private func getProductsByCategory(mainCategory: String) {
        productServiceManager.getProductsBy(category: mainCategory, site: siteId) { [weak self]  (result, _, _) in
            switch result {
            case .success(let response):
                self?.updateProductCells(products: response.products)
            case .failure(let error):
                self?.showEmptyState(error: error)
            }
        }
    }
    
    /**
     Update cells in viewModel and view.
     - Parameter categories: categories from service.
     */
    private func updateSubcategoriesCells(categories: [MLChildrenCategory]) {
        self.subcategories = builder.createSubcategoriesCell(subcategories: categories)
        self.reloadCollectionView?(subcategories.count)
    }
    
    /**
     Update cells in viewModel and view.
     - Parameter products: products from service.
     */
    private func updateProductCells(products: [MLProduct]) {
        guard !products.isEmpty else {
            showEmptyState(error: .unknown)
            return
        }
        
        
        
        self.productsCells = builder.createProductsCell(products: products,
                                                        avedCurrencyID: savedCurrencyID)
        self.reloadTableView?(productsCells.count)
    }
    
    /**
     Show the empty state witth a message by error.
     - Parameter error: error obtained.
     */
    private func showEmptyState(error: ServicesResponseError) {
        let emptyStateElements = builder.getEmptyStateElements(error: error)
        self.updateEmptyState?(true,
                               emptyStateElements.message,
                               emptyStateElements.image)
    }
    
    private func goToProduct(index: Int) {
        let cell = subcategories[index]
        
        if let id = cell.subcategory.id, let name = cell.subcategory.name {
            let newCategory = MLCategory(id: id, name: name)
            let viewController = ProductsFactory.createProductsViewController(category: newCategory,
                                                                              savedCurrencyID: savedCurrencyID,
                                                                              isFromProducts: true)
            pushView?(viewController)
        }
    }
    
    private func goToProductDetail(index: Int) {
        let product = productsCells[index].product
        let viewController = ProductDetailFactory.createProductDetailViewController(product: product)
        pushView?(viewController)
    }
}

// MARK: - PRODUCTSVIEWMODEL IMPLEMENTATION.
extension ProductsViewModel: ProductsViewModelProtocol {
    func didLoad() {
        showHouseButton?(isFromProducts)
        if let siteId = userDefaultsManager.getSiteId() {
            self.siteId = siteId
        }
        
        guard isFromProducts,
              let mainCategory = category else {
            getSubcategories()
            return
        }
        
        updateTitle?(mainCategory.name)
        getProductsByCategory(mainCategory: mainCategory.id)
    }
    
    func getCellModel(at index: Int, isSubcategory: Bool) -> ViewCellModel {
        guard isSubcategory else { return productsCells[index] }
        return subcategories[index]
    }
    
    func didSelect(at index: Int, isSubcategory: Bool) {
        guard isSubcategory else {
            goToProductDetail(index: index)
            return
        }
        goToProduct(index: index)
    }
}
