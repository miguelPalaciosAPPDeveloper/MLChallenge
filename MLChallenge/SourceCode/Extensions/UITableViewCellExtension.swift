//
//  UITableViewCellExtension.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit

extension UITableViewCell {
    /**
     The 'UINib' object initialized for the cell.
     - Returns: The initialized 'UINib' object.
     **/
    static var nib: UINib {
        return UINib(nibName: String(describing: classForCoder()),
                     bundle: Bundle(for: classForCoder()))
    }

    /**
     The default string used to identify a reusable cell.
     - Returns: The string used to identify a reusable cell.
     **/
    static var reuseIdentifier: String {
        return String(describing: classForCoder())
    }
}
