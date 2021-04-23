//
//  HomeViewModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

class HomeViewModel {
    // MARK: - PROPERTIES:
    var reloadTable: ((Int) -> Void)?
    var pushViewController: ((UIViewController) -> Void)?
    var updateEmptyState: ((Bool, String, UIImage?) -> Void)?
    
    private var cells: [CategoryViewCellModel] = []
    private typealias constants = GeneralConstants
    private let builder = HomeBuilder()
    private let categoriesServiceManager: CategoriesServiceManager
    private let sitesHelper: CoreStoreSitesHelper
    private let userDefaultsManager = UserDefaultsManager()
    private var savedCurrencyID: String = ""
    
    init(categoriesServiceManager: CategoriesServiceManager, sitesHelper: CoreStoreSitesHelper) {
        self.categoriesServiceManager = categoriesServiceManager
        self.sitesHelper = sitesHelper
    }
    
    // MARK: - Private functions.
    private func getCategoriesBy(siteId: String) {
        categoriesServiceManager.getCategories(site: siteId) { [weak self]  (result, _, _) in
            switch result {
            case .success(let categories):
                self?.updateCells(categories: categories)
            case .failure(let error):
                self?.showEmptyState(error: error)
            }
        }
    }
    
    /**
     Update cells in viewModel and view.
     - Parameter categories: categories from service.
     */
    private func updateCells(categories: [MLCategory]) {
        self.cells = builder.createCellsBy(categories: categories)
        self.reloadTable?(cells.count)
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
}

// MARK: - HOMEVIEWMODELPROTOCOL IMPLEMENTATION.
extension HomeViewModel: HomeViewModelProtocol {
    func getCategories() {
        if let siteValues = sitesHelper.fetchSiteSelected(),
           let siteId = siteValues.id {
            savedCurrencyID = siteValues.defaultCurrencyID ?? ""
            getCategoriesBy(siteId: siteId)
        } else if let siteId = userDefaultsManager.getSiteId() {
            getCategoriesBy(siteId: siteId)
        }
    }
    
    func getCellModel(at index: Int) -> ViewCellModel {
        return cells[index]
    }
    
    func didSelect(at index: Int) {
        let cell = cells[index]
        let viewController = ProductsFactory.createProductsViewController(category: cell.category,
                                                                          savedCurrencyID: savedCurrencyID)
        pushViewController?(viewController)
    }
    
    func didTapInformationButton() {
        let viewController = SiteSelectorFactory.createSiteSelectorViewController(isFromHome: true)
        pushViewController?(viewController)
    }
    
    func search(_ text: String) {
        let query = text.replacingOccurrences(of: " ", with: "+")
        let viewController = ProductsFactory.createProductsViewController(productQuery: query,
                                                                          savedCurrencyID: savedCurrencyID)
        pushViewController?(viewController)
    }
    
    func validate(editingField: UITextField, editingText: String, shouldChangeCharactersIn: NSRange, replacementString: String) -> Bool {
        guard let textRange = Range(shouldChangeCharactersIn, in: editingText) else { return false }
        let finalText = editingText.replacingCharacters(in: textRange, with: replacementString)
        let range = NSRange(finalText.startIndex..., in: finalText)
        
        guard let regularExpression = try? NSRegularExpression(pattern: constants.searchRegex, options: []) else {
          return false
        }

        return regularExpression.firstMatch(in: finalText, options: [], range: range) != nil
    }
}
