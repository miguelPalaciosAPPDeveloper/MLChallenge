//
//  OnboardingViewCellModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import Foundation

struct OnbopardingViewCellModel: ViewCellModel {
    var reuseIdentifier: String { return OnboardingViewCell.reuseIdentifier }
    let animation: String
    let title: String
    let description: String
}
