//
//  CoreStoreMapper.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 14/04/21.
//

import Foundation
import CoreStore
import MLChallengeAPI

/**
 Class to add new elements to data base.
 */
final class CoreStoreMapper {
    /**
     Create a new site into data base.
     - Parameter model: model with site information,
     - Parameter transaction: Object to manage transaction between data base.
     */
    func newSite(_ model: MLSite, transaction: BaseDataTransaction) {
        let site = transaction.create(Into<SitesDBO>())
        site.isSelected        = false
        site.id                = model.id
        site.name              = model.name
        site.defaultCurrencyID = model.defaultCurrencyID
    }
}
