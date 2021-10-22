//
//  ViewPresentable.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import UIKit
import Foundation

protocol ViewPresentable {
    var titleAppearance: LabelAppearance { get }
    var subtitleAppearance: LabelAppearance { get }
}

struct CellAppearance: ViewPresentable {
    let titleAppearance: LabelAppearance
    let subtitleAppearance: LabelAppearance
}

struct ProfileViewAppearance: ViewPresentable {
    let titleAppearance: LabelAppearance
    let subtitleAppearance: LabelAppearance
}

enum LabelAppearance {
    case header
    case title
    case subtitle
    case profileTitle
    case profileSubtitle
    
    var font: UIFont {
        switch self {
        case .header: return UIFont.boldSystemFont(ofSize: 18.0)
        case .title: return UIFont.boldSystemFont(ofSize: 20.0)
        case .subtitle: return UIFont.italicSystemFont(ofSize: 14.0)
        case .profileTitle: return UIFont.boldSystemFont(ofSize: 44.0)
        case .profileSubtitle: return UIFont.italicSystemFont(ofSize: 20.0)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .header, .title, .profileTitle: return .black
        case .subtitle: return .gray
        case .profileSubtitle: return .darkGray
        }
    }
    
    var numberOfLines: Int {
        switch self {
        case .title, .profileTitle, .profileSubtitle: return 0
        case .header: return 1
        case .subtitle: return 2
        }
    }
}
