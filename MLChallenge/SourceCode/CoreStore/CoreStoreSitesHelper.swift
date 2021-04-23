//
//  CoreStoreSitesHelper.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 14/04/21.
//

import Foundation
import CoreStore
import MLChallengeAPI

final class CoreStoreSitesHelper {
    // MARK: - PROPERTIES.
    private let manager: CoreStoreManager
    
    init(manager: CoreStoreManager) {
        self.manager = manager
    }
    
    // MARK: - SAVE.
    /**
     Save new site into data base.
     - Parameter sites: object with site information.
     - Parameter completion: response when the save action is finished.
     */
    func saveSites(_ sites: [MLSite], completion: (() -> Void)? = nil) {
        let mapper = CoreStoreMapper()
        
        manager.dataStack.perform(asynchronous: { transaction in
            sites.forEach({ mapper.newSite($0, transaction: transaction) })
        }, completion: {_ in completion?() })
    }
    
    // MARK: - UPDATE.
    /**
     Update site selected .
     - Parameter id: site id.
     */
    func updateSelectedSite(id: String) {
        guard let site = manager.dataStack.fetchOne(From<SitesDBO>().where(\.isSelected == true)) else {
            updateSites(id: id)
            return
        }
        guard site.id != id else { return }
        site.isSelected = false
        updateSites(id: id)
    }
    
    /**
     Update site selected .
     - Parameter id: site id.
     */
    private func updateSites(id: String) {
        if let site = manager.dataStack.fetchOne(From<SitesDBO>()
                                                    .where(\.id == id && \.isSelected == false)) {
            site.isSelected = true
        }
    }
    
    // MARK: - FETCH.
    /**
     Get all sites saved.
     - Returns: sites.
     */
    func fetchSites() -> [SitesDBO]? {
        return manager.dataStack.fetchAll(From<SitesDBO>())
    }
    
    /**
     Get site selected in Site selector.
     - Returns: data base object with site information.
     */
    func fetchSiteSelected() -> SitesDBO? {
        return manager.dataStack.fetchOne(From<SitesDBO>().where(\.isSelected == true))
    }
}
