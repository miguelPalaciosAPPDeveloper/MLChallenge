//
//  SiteSelectorFactory.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 19/04/21.
//

import UIKit
import MLChallengeAPI

struct SiteSelectorFactory {
    static func createSiteSelectorViewController(isFromHome: Bool = true) -> UIViewController {
        let view = SiteSelectorViewController()
        let userDefaultsManager = UserDefaultsManager()
        let manager = UIApplication.shared.appDelegate.coreStoreManager
        let viewModel = SiteSelectorViewModel(sitesServiceManager: SitesServiceManagerImplementation(),
                                              sitesHelper: CoreStoreSitesHelper(manager: manager),
                                              isFromHome: isFromHome)
        
        view.viewModel = viewModel
        
        if isFromHome { return view }
        
        guard userDefaultsManager.onboadingIsAvailable() else {
            let navigationController = UINavigationController(rootViewController: view)
            navigationController.modalPresentationStyle = .fullScreen
            return navigationController
        }
        return view
    }
}
