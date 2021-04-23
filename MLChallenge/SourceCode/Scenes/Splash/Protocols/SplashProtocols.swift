//
//  SplashProtocols.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 15/04/21.
//

import UIKit
import MLChallengeAPI

// MARK: - VIEW PROTOCOL.
protocol SplashViewProtocol {
    var viewModel: SplashViewModelProtocol? { get set }
}

// MARK: - VIEWMODEL PROTOCOL.
protocol SplashViewModelProtocol: class {
    var presentOnboarding: ((UIViewController) -> Void)? { get set }
    var goToHome: (([UIViewController]) -> Void)? { get set }
    
    func getSites()
}
