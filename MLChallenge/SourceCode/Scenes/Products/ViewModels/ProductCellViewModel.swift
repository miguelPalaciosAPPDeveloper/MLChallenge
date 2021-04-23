//
//  ProductCellViewModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

class ProductCellViewModel {
    // MARK: - PROPERTIES.
    var updatePrice: ((String) -> Void)?
    var updateOffText: ((String) -> Void)?
    var productImage: ((UIImage?) -> Void)?
    var updateShipping: ((String) -> Void)?
    var updateInstallments: ((String) -> Void)?
    
    private var savedCuurrency = ""
    private typealias constants = GeneralConstants
    private let localizables = MLStringsLocalizables()
    private let downloadServiceManager: DownloadProductImageManager
    private let productImageCacheManager: ProductImageCacheManager
    
    init(downloadServiceManager: DownloadProductImageManager, productImageCacheManager: ProductImageCacheManager) {
        self.downloadServiceManager = downloadServiceManager
        self.productImageCacheManager = productImageCacheManager
    }
    
    private func setPrice(product: MLProduct) {
        let price = product.price ?? 0.0
        let priceOff = product.prices?.prices.first(where: { $0.type == constants.pricePromotionType })
        let productPrice: Double = priceOff?.amount ?? price
        let currencyID = priceOff?.currencyID ?? ""
        
        setInstallments(installments: product.installments,
                        priceWithFormat: productPrice.convertToCurrencyFormat(),
                        useInstallments: currencyID == constants.americanCurrencyID)
        
        guard let metaData = priceOff?.metadata, let percentage = metaData.campaignDiscountPercentage else { return }
        updateOffText?("\(percentage.round(to: 0))\(localizables.productsOff)")
    }
    
    private func setInstallments(installments: MLProductInstallments?, priceWithFormat price: String, useInstallments: Bool) {
        guard let quantity = installments?.quantity, let amount = installments?.amount else {
            updatePrice?(price)
            return
        }
        updateInstallments?("\(quantity)x \(amount.round(to: 2))")
        
        let newPrice = useInstallments ? (Double(quantity) * amount).convertToCurrencyFormat() : price
        updatePrice?(newPrice)
    }
    
    private func setShipping(shipping: MLProductShipping?) {
        if shipping?.freeShipping == true {
            updateShipping?(localizables.productsFreeShipping)
        }
    }
}

// MARK: - PRODUCTCELLVIEWMODELPROTOCOL IMPLEMENTATION.
extension ProductCellViewModel: ProductCellViewModelProtocol {
    func setupCell(product: MLProduct, savedCurrencyID: String) {
        savedCuurrency = savedCurrencyID
        
        setPrice(product: product)
        setShipping(shipping: product.shipping)
    }
    
    func downloadImage(thumbnail: String) {
        guard let image = productImageCacheManager.getImageInCache(path: thumbnail) else {
            downloadServiceManager.downloadImage(thumbnail: thumbnail) { [weak self] (result, _, _) in
                if case let .success(response) = result, let image =  UIImage(data: response) {
                    self?.productImageCacheManager.saveImage(image: image, imageUrl: thumbnail)
                    self?.productImage?(image)
                }
            }
            return
        }
        self.productImage?(image)
    }
}
