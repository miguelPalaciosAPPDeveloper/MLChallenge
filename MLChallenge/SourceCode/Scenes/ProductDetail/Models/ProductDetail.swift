//
//  ProductDetail.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import UIKit

struct ProductDetail {
    // MARK: - DETAIL PRICE CELL.
    var image: UIImage? = nil
    var off: String = ""
    var name: String = ""
    var price: String = ""
    var regularPrice: String = ""
    var installments: String = ""
    var newProductText: String = ""
    
    // MARK: - PRODUCT AVAILABLE CELL.
    var soldQuatity: String = ""
    var availableStock: String = ""
    var availableQuantity: String = ""
    var seeInMLButtonText: String = ""
    
    // MARK: - PRODUCT ADDRESS CELL.
    var productAddress: String = ""
    var freeShippingText: String = ""
}
