//
//  UIView+Extensions.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import UIKit
import Foundation

extension UILabel {
    func apply(appearance: LabelAppearance) {
        numberOfLines = appearance.numberOfLines
        font = appearance.font
        textColor = appearance.textColor
    }
}

extension UIImageView {
    func load(url: URL?, completion: ((UIImage) -> Void)? = nil) {
        guard let url = url else { return }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
                completion?(image)
            }
        }
    }
}
