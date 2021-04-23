//
//  OnboardingViewModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit

class OnboardingViewModel {
    // MARK: - PROPERTIES.
    var updateButton: ((String, Bool) -> Void)?
    var reloadTable: ((Int) -> Void)?
    var goToSiteSelector: ((UIViewController) -> Void)?
    
    let builder = OnboardingBuilder()
    private let localizables = MLStringsLocalizables()
    private let userDefaultsManager = UserDefaultsManager()
    private var cells: [ViewCellModel] = []
}

// MARK: - ONBOARDING IMPLEMENTATION.
extension OnboardingViewModel: OnboardingViewModelProtocol {
    func didLoad() {
        cells = builder.createCells()
        updateButton?(localizables.mlButtonTitleNext, false)
        reloadTable?(cells.count)
    }
    
    func getCellModel(at index: Int) -> ViewCellModel {
        return cells[index]
    }
    
    func changeButton(at index: Int) {
        let isLastIndex = index == cells.count - 1
        let textButton = isLastIndex ? localizables.mlButtonTitleStart : localizables.mlButtonTitleNext
        updateButton?(textButton, isLastIndex)
    }
    
    func didTapActionButton() {
        let siteSelectorViewController = SiteSelectorFactory.createSiteSelectorViewController(isFromHome: false)
        goToSiteSelector?(siteSelectorViewController)
        userDefaultsManager.hideOnboarding()
    }
}
