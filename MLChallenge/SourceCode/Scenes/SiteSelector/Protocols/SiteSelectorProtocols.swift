//
//  SiteSelectorProtocols.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 18/04/21.
//

import UIKit

protocol SiteSelectorViewProtocol: LoaderPresentable {
    var viewModel: SiteSelectorViewModelProtocol? { get set }
}

protocol SiteSelectorViewModelProtocol: class {
    var reloadTable: ((Int) -> Void)? { get set }
    var showCloseButton: (() -> Void)? { get set }
    var enabledButton: ((Bool) -> Void)? { get set }
    var dismissSiteSelector: (() -> Void)? { get set }
    var goToHome: (([UIViewController]) -> Void)? { get set }
    var updateEmptyState: ((Bool, String, UIImage?) -> Void)? { get set }
    
    func didLoad()
    
    func getCellModel(at index: Int) -> ViewCellModel
    
    func didTapAcceptButton()
    
    func didTapTryAgain()
    
    func didSelect(at index: Int)
}
