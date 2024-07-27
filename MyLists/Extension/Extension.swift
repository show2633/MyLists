//
//  Extension.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

extension UIColor {
    func toHexString() -> String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return String(format: "#%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255)))
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        guard hexSanitized.count == 6 || hexSanitized.count == 8 else { return nil }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        let alpha: CGFloat = hexSanitized.count == 8 ? CGFloat((rgb >> 24) & 0xFF) / 255.0 : 1.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    func toHexString() -> String? {
        let uiColor = UIColor(self)
        return uiColor.toHexString()
    }
}

extension Color {
    init?(hex: String) {
        if let uiColor = UIColor(hex: hex) {
            self.init(uiColor)
        } else {
            return nil
        }
    }
}
