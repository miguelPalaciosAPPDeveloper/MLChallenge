//
//  ProductDetailProtocols.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 22/04/21.
//

import Foundation

protocol ProductDetailViewProtocol: LoaderPresentable {
    var viewModel: ProductDetailViewModelProtocol? { get set }
}

protocol ProductDetailViewModelProtocol: class {
    var openURL: ((URL) -> Void)? { get set }
    var reloadData: ((Int) -> Void)? { get set }
    
    func didLoad()
    
    func getCellModel(at index: Int) -> ViewCellModel
    
    func didTapLink()
}
