//
//  BundleExtension.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 12/04/21.
//

import Foundation

extension Bundle {
    var appVersion: String {
        return (infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
}
