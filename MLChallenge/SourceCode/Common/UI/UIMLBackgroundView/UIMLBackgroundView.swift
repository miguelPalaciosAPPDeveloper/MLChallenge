//
//  UIMLBackgroundView.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 18/04/21.
//

import UIKit

class UIMLBackgroundView: UIView {
    override func draw(_ rect: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        if let colorTop = UIColor.yellowML?.cgColor {
            let colorBottom = UIColor.white.cgColor
            gradient.colors = [colorTop, colorBottom]
            gradient.locations = [0.0, 1.0]
            self.layer.addSublayer(gradient)
        }
    }
}
