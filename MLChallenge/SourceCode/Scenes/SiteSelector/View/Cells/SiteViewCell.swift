//
//  SiteViewCell.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 19/04/21.
//

import UIKit

class SiteViewCell: UITableViewCell {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var selectedView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - PROPERTIES.
    private typealias constants = GeneralConstants
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedView.isHidden = !isSelected
    }
}

// MARK: - VIEWCELLCONFIGURABLE IMPLEMENTATION.
extension SiteViewCell: ViewCellConfigurable {
    func setup(_ model: ViewCellModel) {
        if let cellModel = model as? SiteViewCellModel {
            self.titleLabel.text = cellModel.title
            selectedView.isHidden = !isSelected
            selectedView.addShadow(useShadowPath: true)
            selectedView.layer.cornerRadius = constants.cornerRadius
        }
    }
}
