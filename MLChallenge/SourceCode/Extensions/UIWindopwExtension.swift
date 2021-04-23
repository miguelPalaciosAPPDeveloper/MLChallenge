//
//  UIViewControllerExtension.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 12/04/21.
//

import UIKit

extension UIWindow {
    func setupRootViewController() {
        let navigationControler = UINavigationController()
        navigationControler.viewControllers = [SplashViewFactory.createSplashViewController()]
        self.rootViewController = navigationControler
    }
}
