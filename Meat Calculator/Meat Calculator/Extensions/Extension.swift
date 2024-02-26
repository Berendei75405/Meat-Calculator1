//
//  Extension.swift
//  Meat Calculator
//
//  Created by Novgorodcev on 29.12.2023.
//

import UIKit

extension UIImage {
    
    /// Определения размера картинки
    func scaled(to size: CGSize, scale displayScale: CGFloat = UIScreen.main.scale) -> UIImage {
        let format = UIGraphicsImageRendererFormat.preferred()
        format.scale = displayScale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
