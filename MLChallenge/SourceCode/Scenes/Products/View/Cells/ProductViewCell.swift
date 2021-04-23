//
//  ProductViewCell.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

class ProductViewCell: UITableViewCell {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var offLabel: UILabel!
    @IBOutlet private weak var installmentsLabel: UILabel!
    @IBOutlet private weak var shippingLabel: UILabel!
    @IBOutlet private weak var contentViewCell: UIView!
    
    // MARK: - PROPERTIES.
    private var viewModel: ProductCellViewModelProtocol? { didSet { unbind(from: oldValue) } }
    private typealias constants = GeneralConstants
    private var useInstallments = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    private func bind() {
        viewModel?.productImage = ({ [weak self] image in
            self?.productImageView.image = image
        })
        
        viewModel?.updatePrice = ({ [weak self] text in
            self?.priceLabel.text = text
        })
        
        viewModel?.updateShipping = ({ [weak self] text in
            self?.shippingLabel.text = text
            self?.shippingLabel.isHidden = true
        })
        
        viewModel?.updateInstallments = ({ [weak self] text in
            self?.installmentsLabel.text = text
        })
        
        viewModel?.updateOffText = ({ [weak self] text in
            self?.offLabel.text = text
        })
    }
    
    private func unbind(from viewModel: ProductCellViewModelProtocol?) {
        viewModel?.updatePrice = nil
        viewModel?.productImage = nil
        viewModel?.updateOffText = nil
        viewModel?.updateShipping = nil
        viewModel?.updateInstallments = nil
    }
    
    private func setupView() {
        productImageView.contentMode = .scaleAspectFit
        contentViewCell.addShadow(useShadowPath: false)
        contentViewCell.layer.cornerRadius = constants.cornerRadius
        setupLabels()
    }
    
    private func setupLabels() {
        offLabel.text = ""
        priceLabel.text = ""
        shippingLabel.text = ""
        installmentsLabel.text = ""
        
        shippingLabel.isHidden = true
    }
}

// MARK: - VIEWCELLCONFIGURABLE IMPLEMENTATION.
extension ProductViewCell: ViewCellConfigurable {
    func setup(_ model: ViewCellModel) {
        if let cellModel = model as? ProductViewCellModel {
            setupView()
            titleLabel.text = cellModel.product.title
            viewModel = cellModel.viewModel
            bind()
            viewModel?.setupCell(product: cellModel.product,
                                 savedCurrencyID: cellModel.savedCurrencyID)
            
            guard let thumbnail = cellModel.product.thumbnail else { return }
            viewModel?.downloadImage(thumbnail: thumbnail)
        }
    }
}
