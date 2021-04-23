//
//  HomeBuilder.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

struct HomeBuilder {
    private let localizables = MLStringsLocalizables()
    private typealias constants = GeneralConstants
    
    func createCellsBy(categories: [MLCategory]) -> [CategoryViewCellModel] {
        return categories.compactMap({
            CategoryViewCellModel(category: $0, title: $0.name)
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
