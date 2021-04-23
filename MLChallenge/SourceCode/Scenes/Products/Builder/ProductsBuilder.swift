//
//  ProductsBuilder.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

struct ProductsBuilder {
    private let localizables = MLStringsLocalizables()
    private typealias constants = GeneralConstants
    
    func createSubcategoriesCell(subcategories: [MLChildrenCategory]) -> [SubcategoryViewCellModel] {
        return subcategories.compactMap({ SubcategoryViewCellModel(subcategory: $0) })
    }
    
    func createProductsCell(products: [MLProduct], avedCurrencyID: String) -> [ProductViewCellModel] {
        return products.compactMap({
            ProductViewCellModel(product: $0, viewModel:
                                    ProductCellViewModel(downloadServiceManager: DownloadProductImageManagerImplementation(),
                                                         productImageCacheManager: ProductImageCacheManagerImplementation()),
                                 savedCurrencyID: avedCurrencyID)
        })
    }
    
    func getEmptyStateElements(error: ServicesResponseError) -> (message: String, image: UIImage?) {
        let message: String
        let image: UIImage?
        
        switch error {
        case .noInternetConnection:
            message = localizables.errorInternetMessage
            image = constants.internetErrorImage
        case .unknown:
            message = localizables.productsNotFound
            image = constants.searchErrorImage
        default:
            message = localizables.errorGeneralMessage
            image = constants.generalErrorImage
        }
        return (message: message, image: image)
    }
}
