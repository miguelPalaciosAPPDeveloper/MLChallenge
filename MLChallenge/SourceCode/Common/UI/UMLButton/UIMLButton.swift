//
//  UIMLButton.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit

class UIMLButton: UIView {
    // MARK: - @IBOUTLETS.
    @IBOutlet private weak var buttonTitleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var mlButton: UIButton!
    @IBOutlet private weak var buttonTitleConstraint: NSLayoutConstraint!
    @IBOutlet private weak var buttonTitleCenterConstraint: NSLayoutConstraint!
    @IBOutlet private weak var contentView: UIView!
    
    // MARK: - CONSTANTS.
    private let highPriority: Float = 1000.0
    private let lowPriority: Float = 250.0
    
    // MARK: - PROPERTIES.
    var titleLabel: String = "" {
        didSet {
            self.buttonTitleLabel.text = self.titleLabel
        }
    }
    
    var icon: UIImage? = nil {
        didSet {
            self.iconImageView.image = self.icon
        }
    }
    
    var hiddeIcon: Bool = false {
        didSet {
            self.updateIcon()
        }
    }
    
    var isEnabled: Bool = true {
        didSet {
            self.enabledButton()
        }
    }
    
    weak var delegate: UIMLButtonDelegate?

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
        self.contentView.addShadow(useShadowPath: false)
        self.contentView.layer.cornerRadius = self.frame.height / 2.0
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    private func updateIcon() {
        self.buttonTitleConstraint.priority = UILayoutPriority(self.hiddeIcon ? self.lowPriority : self.highPriority)
        self.buttonTitleCenterConstraint.priority = UILayoutPriority(self.hiddeIcon ? self.highPriority :  self.lowPriority)
        self.iconImageView.isHidden = self.hiddeIcon
        self.contentView.layoutIfNeeded()
    }
    
    private func enabledButton() {
        self.contentView.backgroundColor = self.isEnabled ? .yellowML : .grayML
        self.mlButton.isEnabled = self.isEnabled
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        delegate?.action(.normal, sender: self)
    }
}
