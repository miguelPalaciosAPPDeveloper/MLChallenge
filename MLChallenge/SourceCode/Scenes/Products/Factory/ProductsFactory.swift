//
//  ProductsFactory.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

struct ProductsFactory {
    static func createProductsViewController(productQuery: String? = nil,
                                             category: MLCategory? = nil,
                                             savedCurrencyID: String,
                                             isFromProducts: Bool = false) -> UIViewController {
        let view = ProductsViewController()
        let viewModel = ProductsViewModel(productServiceManager: ProductsServiceManagerImplementation(),
                                          categoriesServiceManager: CategoriesServiceManagerImplementation(),
                                          productQuery: productQuery,
                                          category: category,
                                          savedCurrencyID: savedCurrencyID,
                                          isFromProducts: isFromProducts)
        
        view.viewModel = viewModel
        
        return view
    }
}
