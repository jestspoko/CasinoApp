//
//  UIColor+Extension.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 28/06/2022.
//

import UIKit

extension UIColor {
    static func from(string: String) -> UIColor? {
        guard let r1 = string.range(of: "RGB(")?.upperBound, let r2 = string.range(of: ")")?.lowerBound else { return nil }
        
        let hexColor = String(string[r1..<r2])
        let scanner = Scanner(string: hexColor)
        
        var color:UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension UIColor {
    func isEqualTo(_ color: UIColor) -> Bool {
            var red1: CGFloat = 0, green1: CGFloat = 0, blue1: CGFloat = 0, alpha1: CGFloat = 0
            getRed(&red1, green:&green1, blue:&blue1, alpha:&alpha1)

            var red2: CGFloat = 0, green2: CGFloat = 0, blue2: CGFloat = 0, alpha2: CGFloat = 0
            color.getRed(&red2, green:&green2, blue:&blue2, alpha:&alpha2)

            return red1 == red2 && green1 == green2 && blue1 == blue2 && alpha1 == alpha2
        }
}
