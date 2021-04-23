//
//  UIViewExtension.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit
extension UIView {
    func addShadow(color: UIColor? = .black,
                   alpha: CGFloat = 1.0,
                   valueX: CGFloat = 0,
                   valueY: CGFloat = 1.0,
                   blur: CGFloat = 4.0,
                   useShadowPath: Bool) {
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOpacity = Float(alpha)
        self.layer.shadowOffset = CGSize(width: valueX, height: valueY)
        self.layer.shadowRadius = blur / 2.0
        self.layer.shadowPath = useShadowPath ? CGPath(rect: self.bounds,
                                                       transform: nil) : nil
        self.clipsToBounds = false
    }
    
    func xibSetup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        
        return view
    }
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        if let colorBottom = UIColor.yellowML?.cgColor,
           let colorTop = UIColor.grayML?.cgColor {
            gradient.colors = [colorTop, colorBottom]
            gradient.locations = [0.0, 1.0]
            self.layer.addSublayer(gradient)
        }
    }
}
