//
//  UserDefaultsManager.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import Foundation
import MLChallengeAPI

class UserDefaultsManager {
    // MARK: - PROPERTIES
    private typealias keys = UserDefaultsKeys
    private let userDefaults = UserDefaults.standard
    
    // MARK: - ONBOARDING
    func onboadingIsAvailable() -> Bool {
        return !userDefaults.bool(forKey: keys.showOnboardingKey)
    }
    
    func hideOnboarding() {
        userDefaults.set(true, forKey: keys.showOnboardingKey)
    }
    
    // MARK: - SITES SELECTOR
    func sitesSelectorIsAvailable() -> Bool {
        return !userDefaults.bool(forKey: keys.showSitesKey)
    }
    
    func hideSitesSelector() {
        userDefaults.set(true, forKey: keys.showSitesKey)
    }
    
    func saveSiteId(_ id: String) {
        userDefaults.set(id, forKey: keys.siteIdKey)
    }
    
    func getSiteId() -> String? {
        return userDefaults.object(forKey: keys.siteIdKey) as? String
    }
}
