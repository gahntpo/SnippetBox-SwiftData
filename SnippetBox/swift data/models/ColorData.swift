//
//  ColorData.swift
//  SnippetBox
//
//  Created by Karin Prater on 10.10.23.
//

import SwiftUI

struct ColorData: Codable {
    var red: Double = 0
    var green: Double = 0
    var blue: Double = 0
    var opacity: Double = 1
    
    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }
    
    init(red: Double, green: Double, blue: Double, opacity: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
    
    init(color: Color)  {
        let components = color.cgColor?.components ?? []
  
        if components.count > 0 {
            self.red  = Double(components[0])
        }
        
        if components.count > 1 {
            self.green = Double(components[1])
        }
        
        if components.count > 2 {
            self.blue = Double(components[2])
        }
        
        if components.count > 3 {
            self.opacity = Double(components[3])
        }
    }
}
