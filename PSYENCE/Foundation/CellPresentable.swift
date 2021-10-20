//
//  CellPresentable.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import UIKit
import Foundation

protocol CellPresentable {
    var titleAppearance: LabelAppearance { get }
    var subtitleAppearance: LabelAppearance { get }
}

struct CellAppearance: CellPresentable {
    let titleAppearance: LabelAppearance
    let subtitleAppearance: LabelAppearance
}

enum LabelAppearance {
    case header
    case title
    case subtitle
    
    var font: UIFont {
        switch self {
        case .header: return UIFont.boldSystemFont(ofSize: 18.0)
        case .title: return UIFont.boldSystemFont(ofSize: 20.0)
        case .subtitle: return UIFont.italicSystemFont(ofSize: 14.0)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .header, .title: return .black
        case .subtitle: return .gray
        }
    }
    
    var numberOfLines: Int {
        switch self {
        case .header: return 1
        case .title: return 0
        case .subtitle: return 2
        }
    }
}
