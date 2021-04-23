//
//  ProductViewCellModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import Foundation
import MLChallengeAPI

struct ProductViewCellModel: ViewCellModel {
    var reuseIdentifier: String { return ProductViewCell.reuseIdentifier }
    let product: MLProduct
    let viewModel: ProductCellViewModel
    let savedCurrencyID: String
}
