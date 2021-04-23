//
//  ProductDetailViewModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import UIKit
import MLChallengeAPI

class ProductDetailViewModel {
    // MARK: - PROPERTIES.
    var openURL: ((URL) -> Void)?
    var reloadData: ((Int) -> Void)?
    
    private typealias constants = GeneralConstants
    
    private var cells: [ViewCellModel] = []
    private var productDetail = ProductDetail()
    private let builder = ProductDetailBuilder()
    private let localizables = MLStringsLocalizables()
    private let downloadServiceManager: DownloadProductImageManager
    private let productImageCacheManager: ProductImageCacheManager
    private let product: MLProduct
    
    init(downloadServiceManager: DownloadProductImageManager,
         productImageCacheManager: ProductImageCacheManager,
         product: MLProduct) {
        self.downloadServiceManager = downloadServiceManager
        self.productImageCacheManager = productImageCacheManager
        self.product = product
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    private func downloadImage(_ thumbnail: String) {
        guard let image = productImageCacheManager.getImageInCache(path: thumbnail) else {
            downloadServiceManager.downloadImage(thumbnail: thumbnail) { [weak self] (result, _, _) in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        self?.setupProductDetail()
                        return
                    }
                    self?.productImageCacheManager.saveImage(image: image, imageUrl: thumbnail)
                    self?.productDetail.image = image
                    self?.setupProductDetail()
                case .failure:
                    self?.productDetail.image = constants.generalErrorImage
                    self?.setupProductDetail()
                }
            }
            return
        }
        
        self.productDetail.image = image
        self.setupProductDetail()
    }
    
    private func setupProductDetail() {
        let priceOff = product.prices?.prices.first(where: { $0.type == constants.pricePromotionType })
        let currencyID = priceOff?.currencyID ?? ""
        let isAmericanCurrency = currencyID == constants.americanCurrencyID
        let productNewTitle = product.condition == constants.productConditionNew ? localizables.productNewTitle : ""
        
        productDetail.name = product.title ?? ""
        productDetail.newProductText = productNewTitle
        
        setAvailableInformation()
        setAddress(product.address)
        setShipping(product.shipping)
        setPrice(price: product.price ?? 0.0, priceOff: priceOff)
        setInstallments(installments: product.installments,
                        useInstallments: isAmericanCurrency)
        
        cells = builder.createCells(model: productDetail)
        reloadData?(cells.count)
    }
    
    private func setPrice(price: Double, priceOff: MLPrice?) {
        let productPrice: Double = priceOff?.amount ?? price
        
        productDetail.price = productPrice.convertToCurrencyFormat()
        
        setRegularPrice(productPrice: productPrice)
        
        guard let metaData = priceOff?.metadata, let percentage = metaData.campaignDiscountPercentage else { return }
        productDetail.off = "\(percentage.round(to: 0))\(localizables.productsOff)"
    }
    
    private func setRegularPrice(productPrice: Double) {
        let priceStandard = product.prices?.prices.first(where: { $0.type == constants.priceStandardType })
        if let regularPrice: Double = priceStandard?.amount,
           regularPrice > productPrice {
            productDetail.regularPrice = "\(regularPrice.convertToCurrencyFormat()) \(localizables.productRegularPrice)"
        }
    }
    
    private func setInstallments(installments: MLProductInstallments?, useInstallments: Bool) {
        guard let quantity = installments?.quantity,
              let amount = installments?.amount else {
            return
        }
        
        productDetail.installments = "\(quantity)x \(amount.round(to: 2))"
        
        guard useInstallments else { return }
        productDetail.price = (Double(quantity) * amount).convertToCurrencyFormat()
    }
    
    private func setShipping(_ shipping: MLProductShipping?) {
        if shipping?.freeShipping == true {
            productDetail.freeShippingText = localizables.productsFreeShipping
        }
    }
    
    private func setAddress(_ address: MLProductAddress?) {
        guard let productAddress = address else { return }
        productDetail.productAddress = "\(productAddress.cityName), \(productAddress.stateName)"
    }
    
    private func setAvailableInformation() {
        
        if let permalink = product.permalink, !permalink.isEmpty {
            productDetail.seeInMLButtonText = localizables.productSeeInMercadoLibre
        }
        
        guard let soldAvailable = product.soldQuantity,
              let productsAvailable = product.availableQuantity else {
            productDetail.availableStock = localizables.productNotAvailableStock
            return
        }
        
        productDetail.availableStock = localizables.productAvailableStock
        productDetail.soldQuatity = "(\(soldAvailable) \(localizables.productsSold))"
        productDetail.availableQuantity = "\(productsAvailable) \(localizables.productAvailable)"
        
        if productsAvailable == 0 {
            productDetail.availableStock = localizables.productNotAvailableStock
        }
    }
}

// MARK: - PRODCUTDETAILVIEWMODELPROTOCOL IMPLEMENTATION.
extension ProductDetailViewModel: ProductDetailViewModelProtocol {
    func didLoad() {
        guard let thumbnail = product.thumbnail else { return }
        downloadImage(thumbnail)
    }
    
    func getCellModel(at index: Int) -> ViewCellModel {
        return cells[index]
    }
    
    func didTapLink() {
        guard let permalink = product.permalink,
              let url = URL(string: permalink) else { return }
        openURL?(url)
    }
}
