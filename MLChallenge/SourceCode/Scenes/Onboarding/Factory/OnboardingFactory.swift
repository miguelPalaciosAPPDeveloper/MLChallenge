//
//  OnboardingFactory.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit

struct OnboardingFactory {
    /**
     Create a new instance to present onboarding screen.
     - Returns: UIViewController to present.
     */
    static func createOnboardingViewController() -> UIViewController {
        let view = OnboardingViewController()
        let viewModel = OnboardingViewModel()
        
        view.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.modalPresentationStyle = .fullScreen
        
        return navigationController
    }
}
