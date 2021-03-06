//
//  FlagsHelper.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 19/04/21.
//

import Foundation

enum Flags: String, RawRepresentable {
    case honduras = "Honduras"
    case dominicana = "Dominicana"
    case guatemala = "Guatemala"
    case elSalvador = "El Salvador"
    case ecuador = "Ecuador"
    case paraguay = "Paraguay"
    case chile = "Chile"
    case nicaragua = "Nicaragua"
    case mexico = "Mexico"
    case panama = "Panamรก"
    case costaRica = "Costa Rica"
    case peru = "Perรบ"
    case cuba = "Cuba"
    case brasil = "Brasil"
    case bolivia = "Bolivia"
    case venezuela = "Venezuela"
    case uruguay = "Uruguay"
    case argentina = "Argentina"
    case colombia = "Colombia"
    
    var value: String {
        return "\(self.flag) \(self.rawValue)"
    }
    
    var flag: String {
        switch self {
        case .honduras:
            return "๐ญ๐ณ"
        case .dominicana:
            return "๐ฉ๐ด"
        case .guatemala:
            return "๐ฌ๐น"
        case .elSalvador:
            return "๐ธ๐ป"
        case .ecuador:
            return "๐ช๐จ"
        case .paraguay:
            return "๐ต๐พ"
        case .chile:
            return "๐จ๐ฑ"
        case .nicaragua:
            return "๐ณ๐ฎ"
        case .mexico:
            return "๐ฒ๐ฝ"
        case .panama:
            return "๐ต๐ฆ"
        case .costaRica:
            return "๐จ๐ท"
        case .peru:
            return "๐ต๐ช"
        case .cuba:
            return "๐จ๐บ"
        case .brasil:
            return "๐ง๐ท"
        case .bolivia:
            return "๐ง๐ด"
        case .venezuela:
            return "๐ป๐ช"
        case .uruguay:
            return "๐บ๐พ"
        case .argentina:
            return "๐ฆ๐ท"
        case .colombia:
            return "๐จ๐ด"
        }
    }
}
