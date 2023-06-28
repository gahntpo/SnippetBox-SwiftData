//
//  Color+Helper.swift
//  SlipboxProject
//
//  Created by Karin Prater on 28.11.22.
//

import SwiftUI

extension Color {
    
    init?(hex: String) {
        var hexNormalized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexNormalized = hexNormalized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var r: Double = 0.0
        var g: Double = 0.0
        var b: Double = 0.0
        var a: Double = 1.0
        let length = hexNormalized.count

        Scanner(string: hexNormalized).scanHexInt64(&rgb)

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    
    func toHex() -> String? {
        
        guard let components = cgColor?.components, components.count > 2 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a: Float = 1
        
        if components.count == 4 {
            a = Float(components[3])
        }
        
        let hex = String(format: "%02lX%02lX%02lX%02lX",
                         lroundf(r * 255),
                         lroundf(g * 255),
                         lroundf(b * 255),
                         lroundf(a * 255))
        
        return hex
    }
}
