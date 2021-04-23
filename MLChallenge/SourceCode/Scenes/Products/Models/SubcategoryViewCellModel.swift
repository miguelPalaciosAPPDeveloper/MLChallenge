//
//  SubcategoryViewCellModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import Foundation
import MLChallengeAPI

struct SubcategoryViewCellModel: ViewCellModel {
    var reuseIdentifier: String { return SubcategoryViewCell.reuseIdentifier }
    let subcategory: MLChildrenCategory
}
