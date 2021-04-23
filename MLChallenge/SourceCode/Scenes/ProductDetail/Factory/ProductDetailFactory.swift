//
//  ProductDetailFactory.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import UIKit
import MLChallengeAPI

struct ProductDetailFactory {
    static func createProductDetailViewController(product: MLProduct) -> UIViewController {
        let view = ProductDetailViewController()
        let viewModel = ProductDetailViewModel(downloadServiceManager: DownloadProductImageManagerImplementation(),
                                               productImageCacheManager: ProductImageCacheManagerImplementation(),
                                               product: product)
        
        view.viewModel = viewModel
        
        return view
    }
}
