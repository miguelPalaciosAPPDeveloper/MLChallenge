//
//  AppUtility.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 18/04/21.
//

import UIKit

/**
 Class to lock orientation for any screens.
 */
struct AppUtility {
    /**
     Save value to lock orientatiion.
     - Parameter orientation: Device orientation (up, landscape left or landscape right) for default is portrait.
     */
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask = .portrait) {
        UIApplication.shared.appDelegate.orientationLock = orientation
    }
    
    static func rotateView(_ orientation: UIInterfaceOrientationMask) {
        self.lockOrientation(.all)
        UIDevice.current.setValue(UIDevice.current.orientation.rawValue, forKey: "orientation")
    }
}
