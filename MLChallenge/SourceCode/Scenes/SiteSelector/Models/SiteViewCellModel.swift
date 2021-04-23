//
//  SiteViewCellModel.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 19/04/21.
//

import Foundation
import MLChallengeAPI

struct SiteViewCellModel: ViewCellModel {
    var reuseIdentifier: String { return SiteViewCell.reuseIdentifier }
    let siteID: String
    let title: String
}
