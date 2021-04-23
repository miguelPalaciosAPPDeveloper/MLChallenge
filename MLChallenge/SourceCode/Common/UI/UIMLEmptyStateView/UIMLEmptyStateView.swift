//
//  UIMLEmptyStateView.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit

class UIMLEmptyStateView: UIView {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var errorImageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!

    @IBOutlet private weak var contentButton: UIView!
    @IBOutlet private weak var retryButton: UIButton!
    
    // MARK: - PROPERTIES.
    weak var delegate: UIMLButtonDelegate?
    
    var message: String = "" {
        didSet {
            self.messageLabel.text = message
        }
    }
    
    var errorImage: UIImage? {
        didSet {
            self.errorImageView.image = errorImage
        }
    }
    
    var hiddeButton: Bool = false {
        didSet {
            self.contentButton.isHidden = hiddeButton
        }
    }
    
    // MARK: - INIT FUNCTIONS.
    override private init(frame: CGRect) {
      super.init(frame: frame)
        xibSetup()
    }

    public required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
    // MARK: - SETUP FUNCTIONS.
    private func setupView() {
        self.contentButton.backgroundColor = .yellowML
        self.contentButton.addShadow(useShadowPath: false)
        self.contentButton.layer.cornerRadius = self.contentButton.frame.height / 2.0
    }
    
    // MARK: - IBACTIONS.
    @IBAction func retryAction(_ sender: UIButton) {
        delegate?.action(.retry, sender: sender)
    }
}
