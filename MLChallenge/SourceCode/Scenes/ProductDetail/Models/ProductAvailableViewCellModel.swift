//
//  ProductAvailableViewCellModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import Foundation

struct ProductAvailableViewCellModel: ViewCellModel {
    var reuseIdentifier: String { return ProductAvailableViewCell.reuseIdentifier }
    let soldQuatity: String
    let availableStock: String
    let availableQuantity: String
    let seeInMLButtonText: String
}
