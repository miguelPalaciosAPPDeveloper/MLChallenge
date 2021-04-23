//
//  CategoryViewCellModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import Foundation
import MLChallengeAPI

struct CategoryViewCellModel: ViewCellModel {
    var reuseIdentifier: String { return CategoryViewCell.reuseIdentifier }
    let category: MLCategory
    let title: String
}
