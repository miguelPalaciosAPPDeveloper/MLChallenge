//
//  SubcategoryViewCell.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit

class SubcategoryViewCell: UICollectionViewCell {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backgroundTitleView: UIView!
    
    // MARK: - PROPERTIES.
    private typealias constants = GeneralConstants

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

// MARK: - VIEWCELLCONFIGURABLE IMPLEMENTATION.
extension SubcategoryViewCell: ViewCellConfigurable {
    func setup(_ model: ViewCellModel) {
        if let cellModel = model as? SubcategoryViewCellModel {
            self.titleLabel.text = cellModel.subcategory.name
            backgroundTitleView.addShadow(useShadowPath: false)
            backgroundTitleView.layer.cornerRadius = constants.cornerRadius
        }
    }
}
