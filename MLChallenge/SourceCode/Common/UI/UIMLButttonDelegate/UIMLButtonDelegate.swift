//
//  UIMLButtonDelegate.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import Foundation

enum MLButtonType {
    case retry
    case normal
    case urlButton
}

protocol UIMLButtonDelegate: class {
    func action(_ buttonType: MLButtonType, sender: Any)
}
