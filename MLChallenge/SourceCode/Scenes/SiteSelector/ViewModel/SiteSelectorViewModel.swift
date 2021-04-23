//
//  SiteSelectorViewModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 19/04/21.
//

import UIKit
import MLChallengeAPI

class SiteSelectorViewModel {
    // MARK: - PROPERTIES.
    var reloadTable: ((Int) -> Void)?
    var showCloseButton: (() -> Void)?
    var enabledButton: ((Bool) -> Void)?
    var dismissSiteSelector: (() -> Void)?
    var goToHome: (([UIViewController]) -> Void)?
    var updateEmptyState: ((Bool, String, UIImage?) -> Void)?
    
    private let sitesServiceManager: SitesServiceManager
    private let sitesHelper: CoreStoreSitesHelper
    private let isFromHome: Bool
    private let userDefaultsManager = UserDefaultsManager()
    private let builder = SiteSelectorBuilder()
    private var cells: [SiteViewCellModel] = []
    private var selectedIndex = -1
    
    init(sitesServiceManager: SitesServiceManager, sitesHelper: CoreStoreSitesHelper, isFromHome: Bool) {
        self.sitesServiceManager = sitesServiceManager
        self.sitesHelper = sitesHelper
        self.isFromHome = isFromHome
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    /**
     Create cells to show on siteSelector.
     */
    private func createCells() {
        guard let cellsOnDB = sitesHelper.fetchSites(), !cellsOnDB.isEmpty else {
            self.getSites()
            return
        }
        let sites = cellsOnDB.compactMap({
            MLSite(defaultCurrencyID: $0.defaultCurrencyID ?? "",
                   id: $0.id ?? "",
                   name: $0.name ?? "")
        })
        self.updateCells(sites: sites)
    }
    
    /**
     Get site from service If the data base don't have sites.
     */
    private func getSites() {
        sitesServiceManager.getSites { [weak self] (result, _, _) in
            switch result {
            case .success(let sites):
                self?.save(sites: sites)
            case .failure(let error):
                self?.showEmptyState(error: error)
            }
        }
    }
    
    /**
     Save the sites from request.
     - Parameter sites: sites from service.
     */
    private func save(sites: [MLSite]) {
        guard !sites.isEmpty else {
            showEmptyState(error: .unknown)
            return
        }
        
        sitesHelper.saveSites(sites) { [weak self] in
            self?.updateCells(sites: sites)
        }
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
    
    /**
     Update cells in viewModel and view.
     - Parameter sites: sites from service or database.
     */
    private func updateCells(sites: [MLSite]) {
        self.cells = builder.createCellsBy(sites: sites)
        self.reloadTable?(cells.count)
    }
}

// MARK: - SITESELECTORVIEWMODELPROTOCOL IMPLEMENTATION.
extension SiteSelectorViewModel: SiteSelectorViewModelProtocol {
    func didLoad() {
        self.createCells()
        
        guard isFromHome else { return }
        showCloseButton?()
    }
    
    func getCellModel(at index: Int) -> ViewCellModel {
        return cells[index]
    }
    
    func didTapAcceptButton() {
        let cell = self.cells[selectedIndex]
        sitesHelper.updateSelectedSite(id: cell.siteID)
        userDefaultsManager.saveSiteId(cell.siteID)
        userDefaultsManager.hideSitesSelector()
        
        guard isFromHome else {
            self.goToHome?([HomeFactory.createHomeViewController()])
            return
        }
        self.dismissSiteSelector?()
    }
    
    func didSelect(at index: Int) {
        selectedIndex = index
        self.enabledButton?(true)
    }
    
    func didTapTryAgain() {
        self.getSites()
    }
}
