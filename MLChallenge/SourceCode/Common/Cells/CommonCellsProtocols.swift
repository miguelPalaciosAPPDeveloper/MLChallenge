//
//  CommonCellsProtocols.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import Foundation

// MARK: - CELL VIEW.
protocol ViewCellConfigurable {
    func setup(_ model: ViewCellModel)
    
    func setup(_ model: ViewCellModel, delegate: ViewCellDelegate?)
}

extension ViewCellConfigurable {
    func setup(_ model: ViewCellModel) { /* For opttional function */ }

    func setup(_ model: ViewCellModel, delegate: ViewCellDelegate?) {
        self.setup(model)
    }
}

// MARK: - CELL MODEL.
protocol ViewCellModel {
    var reuseIdentifier: String { get }
}

// MARK: - CELL DELEGATE.
protocol ViewCellDelegate: class {
    func didTapActionButtton(_ buttonType: MLButtonType)
}

extension ViewCellDelegate {
    func didTapActionButtton(_ buttonType: MLButtonType) { /* For opttional function */ }
}
