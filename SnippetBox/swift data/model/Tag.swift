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
    var color_: String?
    
    @Attribute(originalName: "creationDate_")
    var creationDate: Date
    
    @Attribute(originalName: "name_")
    var name: String
    
    @Attribute(originalName: "uuid_")
    var uuid: UUID
    
    var snippets_: [Snippet]?
    
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
    
    var snippets: [Snippet] {
        get { self.snippets_ ?? [] }
        set { self.snippets_ = newValue  }
    }
    
    static func delete(_ tag: Tag) {
        if let context = tag.context {
            context.delete(tag)
        }
    }
    
    
    static func example() -> Tag {
        Tag(color_: "000000", name: "my tag")
    }
    
    static func example2() -> Tag {
        Tag(color_: "000000", name: "my very long tag")
    }
    
    static func example3() -> Tag {
        Tag(color_: "000000", name: "something awesome")
    }
}
