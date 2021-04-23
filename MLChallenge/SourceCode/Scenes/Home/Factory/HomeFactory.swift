//
//  HomeFactory.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit
import MLChallengeAPI

struct HomeFactory {
    static func createHomeViewController() -> UIViewController {
        let view = HomeViewController()
        let manager = UIApplication.shared.appDelegate.coreStoreManager
        let viewModel = HomeViewModel(categoriesServiceManager: CategoriesServiceManagerImplementation(),
                                      sitesHelper: CoreStoreSitesHelper(manager: manager))
        
        view.viewModel = viewModel

        return view
    }
}
