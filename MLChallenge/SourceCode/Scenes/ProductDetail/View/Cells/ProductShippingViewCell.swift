//
//  ProductShippingViewCell.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import UIKit

class ProductShippingViewCell: UITableViewCell {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var freeShippingImageView: UIImageView!
    @IBOutlet private weak var shippingLabel: UILabel!
    @IBOutlet private weak var fromLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - VIEWCELLCONFIGURABLE IMPLEMENTATION.
extension ProductShippingViewCell: ViewCellConfigurable {
    func setup(_ model: ViewCellModel) {
        if let cellModel = model as? ProductShippingViewCellModel {
            fromLabel.text = cellModel.productAddress
            shippingLabel.text = cellModel.freeShippingText
            freeShippingImageView.isHidden = cellModel.freeShippingText.isEmpty
        }
    }
}
