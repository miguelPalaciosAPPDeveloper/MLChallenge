//
//  OnboardingViewCell.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit
import Lottie

class OnboardingViewCell: UICollectionViewCell {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var sceneView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sceneContentView: UIView!
    
    // MARK: - PROPERTIES.
    private var animationView: AnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sceneView.backgroundColor = .clear
    }
    
    private func setupAnimation(animation: String) {
      self.layoutIfNeeded()
      self.clearAnimation()
      
      self.animationView = AnimationView(name: animation)
      self.animationView?.frame = self.sceneView.frame
      self.animationView?.loopMode = .loop
      self.animationView?.contentMode = .scaleAspectFit
      
      self.sceneContentView.addSubview(self.animationView)
      self.animationView.play()
    }

    private func clearAnimation() {
      if self.animationView != nil {
        self.animationView.stop()
        self.animationView.removeFromSuperview()
        self.animationView = nil
      }
    }
}

// MARK: VIEWCELLCONFIGURABLE IMPLEMENTATION.
extension OnboardingViewCell: ViewCellConfigurable {
    func setup(_ model: ViewCellModel) {
        if let cellModel = model as? OnbopardingViewCellModel {
            self.titleLabel.text = cellModel.title
            self.descriptionLabel.text = cellModel.description
            self.setupAnimation(animation: cellModel.animation)
        }
    }
}
