//
//  ProductAvailableViewCell.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 21/04/21.
//

import UIKit

class ProductAvailableViewCell: UITableViewCell {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var availabilityLabel: UILabel!
    @IBOutlet private weak var availabilityView: UIView!
    @IBOutlet private weak var quantityAvailableLabel: UILabel!
    @IBOutlet private weak var quantitySoldLabel: UILabel!
    @IBOutlet private weak var seeInMLButton: UIButton!
    
    weak var delegate: ViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func seeInMLAction(_ sender: Any) {
        delegate?.didTapActionButtton(.urlButton)
    }
    
}

// MARK: - VIEWCELLCONFIGURABLE IMPLEMENTATION.
extension ProductAvailableViewCell: ViewCellConfigurable {
    func setup(_ model: ViewCellModel, delegate: ViewCellDelegate?) {
        self.delegate = delegate
        if let cellModel = model as? ProductAvailableViewCellModel {
            quantitySoldLabel.text = cellModel.soldQuatity
            availabilityLabel.text = cellModel.availableStock
            quantityAvailableLabel.text = cellModel.availableQuantity
            seeInMLButton.isHidden = cellModel.seeInMLButtonText.isEmpty
            seeInMLButton.setTitle(cellModel.seeInMLButtonText, for: .normal)
            
            let isHidden = cellModel.availableQuantity.isEmpty && cellModel.soldQuatity.isEmpty
            availabilityView.isHidden = isHidden
        }
    }
}
