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
    case panama = "Panamá"
    case costaRica = "Costa Rica"
    case peru = "Perú"
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
            return "🇭🇳"
        case .dominicana:
            return "🇩🇴"
        case .guatemala:
            return "🇬🇹"
        case .elSalvador:
            return "🇸🇻"
        case .ecuador:
            return "🇪🇨"
        case .paraguay:
            return "🇵🇾"
        case .chile:
            return "🇨🇱"
        case .nicaragua:
            return "🇳🇮"
        case .mexico:
            return "🇲🇽"
        case .panama:
            return "🇵🇦"
        case .costaRica:
            return "🇨🇷"
        case .peru:
            return "🇵🇪"
        case .cuba:
            return "🇨🇺"
        case .brasil:
            return "🇧🇷"
        case .bolivia:
            return "🇧🇴"
        case .venezuela:
            return "🇻🇪"
        case .uruguay:
            return "🇺🇾"
        case .argentina:
            return "🇦🇷"
        case .colombia:
            return "🇨🇴"
        }
    }
}
