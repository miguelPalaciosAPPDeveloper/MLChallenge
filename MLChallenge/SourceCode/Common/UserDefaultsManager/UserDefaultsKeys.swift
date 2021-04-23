//
//  UserDefaultsKeys.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import Foundation

enum UserDefaultsKeys {
    private static let identifier = Bundle.main.bundleIdentifier ?? ""
    
    static let showOnboardingKey = "\(identifier).showOnboarding"
    static let showSitesKey = "\(identifier).showSites"
    static let siteIdKey = "\(identifier).siteID"
}
