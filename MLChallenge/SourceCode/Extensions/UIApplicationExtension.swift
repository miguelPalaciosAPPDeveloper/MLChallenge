//
//  UIApplicationExtension.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 15/04/21.
//

import UIKit

extension UIApplication {
    var appDelegate: AppDelegate {
        return (self.delegate as? AppDelegate) ?? .init()
    }
}
