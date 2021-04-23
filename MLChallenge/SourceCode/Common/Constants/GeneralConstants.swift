//
//  GeneralConstants.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit

enum GeneralConstants {
    // MARK: - GENERAL.
    static let applicationAnimation = "application"
    static let architectureCubeAnimation = "architectureCube"
    static let searchHereAnimation = "searchHere"
    static let rocketStartAnimation = "rocketStart"
    static let estimatedRowHeight: CGFloat = 38.0
    static let searchRegex = "^[[:alnum:][:blank:]]{0,}$"
    static let cornerRadius: CGFloat = 5.0
    
    // MARK: - DOTSBAR
    static let slideBarConstant: CGFloat = 3.0
    static let defaultWidth: CGFloat = 12.0
    static let widthSelected: CGFloat = 24.0
    
    // MARK: - ERROR
    static let generalErrorImage = UIImage(named: "generalError")
    static let internetErrorImage = UIImage(named: "internetError")
    static let searchErrorImage = UIImage(named: "searchError")
    
    // MARK: - PRODUCTS.
    static let pricePromotionType = "promotion"
    static let priceStandardType = "standard"
    static let subcategoryCellSize: CGSize = CGSize(width: 100.0, height: 58.0)
    static let subcategoryLineSpace: CGFloat = 4.0
    static let tableViewCornerRadius: CGFloat = 10.0
    static let americanCurrencyID  = "USD"
    static let productConditionNew = "new"
}
