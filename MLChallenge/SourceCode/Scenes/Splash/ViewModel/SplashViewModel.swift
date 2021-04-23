//
//  SplashViewModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 15/04/21.
//

import UIKit
import MLChallengeAPI

class SplashViewModel {
    // MARK: - PROPERTIES.
    var presentOnboarding: ((UIViewController) -> Void)?
    var goToHome: (([UIViewController]) -> Void)?
    
    private let sitesServiceManager: SitesServiceManager
    private let sitesHelper: CoreStoreSitesHelper
    private let userDefaultsManager = UserDefaultsManager()
    
    init(sitesServiceManager: SitesServiceManager, sitesHelper: CoreStoreSitesHelper) {
        self.sitesServiceManager = sitesServiceManager
        self.sitesHelper = sitesHelper
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    private func save(sites: [MLSite]) {
        sitesHelper.saveSites(sites) { [weak self] in
            self?.goToOnboardingScreen()
        }
    }
    
    private func goToOnboardingScreen() {
        guard userDefaultsManager.onboadingIsAvailable() else {
            goToSiteSelectorScreen()
            return
        }
        presentOnboarding?(OnboardingFactory.createOnboardingViewController())
    }
    
    private func goToSiteSelectorScreen() {
        guard userDefaultsManager.sitesSelectorIsAvailable() else {
            goToHomeScreen()
            return
        }
        let viewController = SiteSelectorFactory.createSiteSelectorViewController(isFromHome: false)
        presentOnboarding?(viewController)
    }
    
    private func goToHomeScreen() {
        if let siteId = userDefaultsManager.getSiteId() {
            sitesHelper.updateSelectedSite(id: siteId)
        }
        
        goToHome?([HomeFactory.createHomeViewController()])
    }
}

// MARK: - SPLASHVIEWMODELPROTOCOL IMPLEMENTATION.
extension SplashViewModel: SplashViewModelProtocol {
    func getSites() {
        sitesServiceManager.getSites { [weak self] (result, _, _) in
            switch result {
            case .success(let model):
                self?.save(sites: model)
            case .failure(_):
                self?.goToOnboardingScreen()
            }
        }
    }
}
