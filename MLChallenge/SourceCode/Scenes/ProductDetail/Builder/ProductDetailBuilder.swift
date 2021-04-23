//
//  ProductDetailBuilder.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import Foundation

struct ProductDetailBuilder {
    func createCells(model: ProductDetail) -> [ViewCellModel] {
        var cells: [ViewCellModel] = []
        
        cells.append(DetailPriceViewCellModel(image: model.image,
                                              off: model.off,
                                              name: model.name,
                                              price: model.price,
                                              regularPrice: model.regularPrice,
                                              installments: model.installments,
                                              newProductText: model.newProductText))
        cells.append(ProductAvailableViewCellModel(soldQuatity: model.soldQuatity,
                                                   availableStock: model.availableStock,
                                                   availableQuantity: model.availableQuantity,
                                                   seeInMLButtonText: model.seeInMLButtonText))
        
        guard !model.productAddress.isEmpty && !model.freeShippingText.isEmpty else {
            return cells
        }

        cells.append(ProductShippingViewCellModel(productAddress: model.productAddress,
                                                  freeShippingText: model.freeShippingText))
        
        return cells
    }
}
