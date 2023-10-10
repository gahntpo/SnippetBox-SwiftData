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
    
    
    var snippets: [Snippet]
    /*
    var snippets: [Snippet] {
        get { self.snippets_ ?? [] }
        set { self.snippets_ = newValue  }
    }
     */
    
    var colorData: ColorData
    
    var color: Color {
        get { colorData.color }
        set { colorData = ColorData(color: newValue)}
    }
    
    //MARK: - Init
    
    init(
        color: Color = Color.black,
        name: String = "",
        snippets: [Snippet] = []
    ) {
        self.creationDate = Date()
        self.uuid = UUID()
        self.colorData = ColorData(color: color)
        self.name = name
        self.snippets = snippets
    }
    
    static func delete(_ tag: Tag) {
        if let context = tag.modelContext {
            context.delete(tag)
        }
    }
    
    static func example() -> Tag {
        Tag(color: Color(red: 1, green: 0, blue: 1), name: "My tag")
    }
    
    static func example2() -> Tag {
        Tag(color: Color(red: 1, green: 1, blue: 0), name: "My very long tag")
    }
    
    static func example3() -> Tag {
        Tag(color: Color(red: 1, green: 0, blue: 0), name: "Something awesome")
    }
}


