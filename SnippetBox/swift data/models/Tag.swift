//
//  Tag.swift
//  SnippetBox
//
//  Created by Karin Prater on 23.06.23.
//
//

import SwiftUI
import SwiftData

@Model final public class Tag {
    
    @Attribute(originalName: "uuid_")
    var uuid: UUID
    
    @Attribute(originalName: "creationDate_")
    var creationDate: Date
    
    @Attribute(originalName: "name_")
    var name: String
    
    var snippets_: [Snippet]?
    
    var snippets: [Snippet] {
        get { self.snippets_ ?? [] }
        set { self.snippets_ = newValue  }
    }
    
    var color_: String?
    
    var color: Color {
        get {
            if let colorHexValue = color_,
               let color = Color(hex: colorHexValue) {
               return color
            } else {
               return Color.black
            }
        }
        set {
           color_ = newValue.toHex()
        }
    }
    
    //MARK: - Init
    
    init(
        color_: String? = nil,
        name: String = "",
        snippets: [Snippet] = []
    ) {
        self.creationDate = Date()
        self.uuid = UUID()
        self.color_ = color_
        self.name = name
        self.snippets = snippets
    }
    
    static func delete(_ tag: Tag) {
        if let context = tag.context {
            context.delete(tag)
        }
    }
    

    
    static func example() -> Tag {
        Tag(color_: "000000", name: "My tag")
    }
    
    static func example2() -> Tag {
        Tag(color_: "4357FF", name: "My very long tag")
    }
    
    static func example3() -> Tag {
        Tag(color_: "435700", name: "Something awesome")
    }
}


struct ColorData: Codable {
    var red: Double = 1
    var green: Double = 1
    var blue: Double = 1
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
