//
//  DetailPriceViewCell.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 21/04/21.
//

import UIKit

class DetailPriceViewCell: UITableViewCell {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNewView: UIView!
    @IBOutlet private weak var productNewLabel: UILabel!
    @IBOutlet private weak var regularPriceLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceOffLabel: UILabel!
    @IBOutlet private weak var installmentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - VIEWCELLCONFIGURABLE IMPLEMENTATION.
extension DetailPriceViewCell: ViewCellConfigurable {
    func setup(_ model: ViewCellModel) {
        if let cellModel = model as? DetailPriceViewCellModel {
            titleLabel.text = cellModel.name
            productImageView.image = cellModel.image
            
            productNewLabel.text = cellModel.newProductText
            productNewView.isHidden = cellModel.newProductText.isEmpty
            
            regularPriceLabel.text = cellModel.regularPrice
            regularPriceLabel.isHidden = cellModel.regularPrice.isEmpty
            
            priceLabel.text = cellModel.price
            
            priceOffLabel.text = cellModel.off
            priceOffLabel.isHidden = cellModel.off.isEmpty
            
            installmentsLabel.text = cellModel.installments
            installmentsLabel.isHidden = cellModel.installments.isEmpty
        }
    }
}
