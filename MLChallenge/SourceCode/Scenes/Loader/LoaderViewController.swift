//
//  LoaderViewController.swift
//  TakeCare
//
//  Created by Miguel Angel De Leon Palacios on 5/22/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {
    // MARK: - IBOutlets.
    @IBOutlet private weak var loaderContainerView: UIView!
    @IBOutlet private weak var centerConstraint: NSLayoutConstraint!
    
    // MARK: - Properties.
    private var animationView: AnimationView?
    private var animation = ""
    private let centerConstant: CGFloat = 0.0
    private let cornerRadius: CGFloat = 6.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLoader()
    }
    
    convenience init(animation: String) {
        self.init(nibName: String(describing: type(of: self)), bundle: nil)
        
        /// Presentation setup.
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
        self.animation = animation
    }
    
    /**
     Setup Loader.
     **/
    private func setupLoader() {
        self.centerConstraint.constant = centerConstant
        self.animationView = AnimationView(name: animation)
        self.animationView?.loopMode = .loop
        self.animationView?.contentMode = .scaleAspectFill
        
        self.loaderContainerView.layer.cornerRadius = cornerRadius
        self.loaderContainerView.addSubview(animationView ?? UIView())
        self.animationView?.translatesAutoresizingMaskIntoConstraints = false
        if let horizontalConstraint = self.animationView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           let verticalConstraint = self.animationView?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,
                                                                                 constant: centerConstant),
           let widthConstraint = self.animationView?
            .widthAnchor
            .constraint(equalToConstant: self.loaderContainerView.frame.width),
           let heightConstraint = self.animationView?
            .heightAnchor
            .constraint(equalToConstant: self.loaderContainerView.frame.height) {
            self.view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        }
        self.animationView?.play()
    }
}
