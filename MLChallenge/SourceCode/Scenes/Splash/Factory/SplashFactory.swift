//
//  SplashFactory.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 15/04/21.
//

import UIKit
import MLChallengeAPI

struct SplashViewFactory {
    /**
     Create a new instance to present splash screen.
     - Returns: UIViewController to present.
     */
    static func createSplashViewController() -> UIViewController {
        let view = SplashViewController()
        let manager = UIApplication.shared.appDelegate.coreStoreManager
        let viewModel = SplashViewModel(sitesServiceManager: SitesServiceManagerImplementation(),
                                        sitesHelper: CoreStoreSitesHelper(manager: manager))
        
        view.viewModel = viewModel
        
        return view
    }
}
