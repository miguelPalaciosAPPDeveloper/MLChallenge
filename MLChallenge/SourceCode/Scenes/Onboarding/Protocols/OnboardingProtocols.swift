//
//  OnboardingProtocols.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit

// MARK: - VIEW PROTOCOL.
protocol OnboardingViewProtocol {
    var viewModel: OnboardingViewModelProtocol? { get set }
}

// MARK: - VIEWMODEL PROTOCOL.
protocol OnboardingViewModelProtocol: class {
    var updateButton: ((String, Bool) -> Void)? { get set }
    var reloadTable: ((Int) -> Void)? { get set }
    var goToSiteSelector: ((UIViewController) -> Void)? { get set }
    
    func didLoad()
    
    func getCellModel(at index: Int) -> ViewCellModel
    
    func changeButton(at index: Int)
    
    func didTapActionButton()
}
