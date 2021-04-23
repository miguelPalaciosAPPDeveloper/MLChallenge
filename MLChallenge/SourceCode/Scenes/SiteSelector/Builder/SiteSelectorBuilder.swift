//
//  SiteSelectorBuilder.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 19/04/21.
//

import UIKit
import MLChallengeAPI

struct SiteSelectorBuilder {
    private let localizables = MLStringsLocalizables()
    private typealias constants = GeneralConstants
    
    func createCellsBy(sites: [MLSite]) -> [SiteViewCellModel] {
        return sites.compactMap({
            SiteViewCellModel(siteID: $0.id, title: Flags(rawValue: $0.name)?.value ?? $0.name)
        })
    }
    
    func getEmptyStateElements(error: ServicesResponseError) -> (message: String, image: UIImage?) {
        var message = localizables.errorGeneralMessage
        var image = constants.generalErrorImage
        
        if error == .noInternetConnection {
            message = localizables.errorInternetMessage
            image = constants.internetErrorImage
        }
        return (message: message, image: image)
    }
}
