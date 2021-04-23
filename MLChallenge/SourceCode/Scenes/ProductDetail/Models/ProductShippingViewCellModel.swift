//
//  ProductShippingViewCellModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import Foundation

struct ProductShippingViewCellModel: ViewCellModel {
    var reuseIdentifier: String { return ProductShippingViewCell.reuseIdentifier }
    let productAddress: String
    let freeShippingText: String
}
