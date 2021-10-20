//
//  Endpoint.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import Foundation

enum Endpoint: String {
    case staffpicks
    
    var url: String {
        switch self {
        case .staffpicks:
            return "/channels/\(rawValue)/videos"
        }
    }
}
