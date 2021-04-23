//
//  SplashViewController.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 15/04/21.
//

import UIKit

class SplashViewController: UIViewController, SplashViewProtocol {
    
    var viewModel: SplashViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.getSites()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setup() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        bind()
    }
    
    private func bind() {
        self.viewModel?.presentOnboarding = ({ [weak self] viewController in
            self?.present(viewController, animated: true, completion: nil)
        })
        
        self.viewModel?.goToHome = ({ [weak self] viewControllers in
            self?.navigationController?.setViewControllers(viewControllers, animated: true)
        })
    }
}
