//
//  OnboardingBuilder.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import Foundation

class OnboardingBuilder {
    private typealias constants = GeneralConstants
    private let localizables = MLStringsLocalizables()
    
    func createCells() -> [ViewCellModel] {
        return [
            OnbopardingViewCellModel(animation: constants.applicationAnimation,
                                     title: localizables.onboardingCellTitle1,
                                     description: localizables.onboardingCellDescription1),
            OnbopardingViewCellModel(animation: constants.architectureCubeAnimation,
                                     title: localizables.onboardingCellTitle2,
                                     description: localizables.onboardingCellDescription2),
            OnbopardingViewCellModel(animation: constants.searchHereAnimation,
                                     title: localizables.onboardingCellTitle3,
                                     description: localizables.onboardingCellDescription3),
            OnbopardingViewCellModel(animation: constants.rocketStartAnimation,
                                     title: localizables.onboardingCellTitle1,
                                     description: localizables.onboardingCellDescription4)
        ]
    }
}
