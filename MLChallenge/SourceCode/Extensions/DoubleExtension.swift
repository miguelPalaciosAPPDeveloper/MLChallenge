//
//  DoubleExtension.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func convertToCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.currencyCode = "MXN"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        return formatter.string(from: NSNumber(value: self)) ?? "$ \(self.round(to: 2))"
    }
}
