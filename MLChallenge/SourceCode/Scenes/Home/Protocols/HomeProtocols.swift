//
//  HomeProtocols.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit

protocol HomeViewProtocol: LoaderPresentable {
    var viewModel: HomeViewModelProtocol? { get set }
}

protocol HomeViewModelProtocol: class {
    var reloadTable: ((Int) -> Void)? { get set }
    var pushViewController: ((UIViewController) -> Void)? { get set }
    var updateEmptyState: ((Bool, String, UIImage?) -> Void)? { get set }
    
    func getCategories()
    
    func getCellModel(at index: Int) -> ViewCellModel
    
    func didSelect(at index: Int)
    
    func didTapInformationButton()
    
    func search(_ text: String)
    
    func validate(editingField: UITextField, editingText: String, shouldChangeCharactersIn: NSRange, replacementString: String) -> Bool
}
