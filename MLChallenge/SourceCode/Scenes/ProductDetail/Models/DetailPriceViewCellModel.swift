//
//  DetailPriceViewCellModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import UIKit

struct DetailPriceViewCellModel: ViewCellModel {
    var reuseIdentifier: String { return DetailPriceViewCell.reuseIdentifier }
    let image: UIImage?
    let off: String
    let name: String
    let price: String
    let regularPrice: String
    let installments: String
    let newProductText: String
}
