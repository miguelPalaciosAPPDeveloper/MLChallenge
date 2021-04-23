//
//  LocalizedExtension.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 17/04/21.
//

import Foundation

var stringsFilename = "MLLocalizables"

extension String {
  var localized: String {
      return NSLocalizedString(self, tableName: stringsFilename, bundle: Bundle.main, value: "", comment: "")
  }
}
