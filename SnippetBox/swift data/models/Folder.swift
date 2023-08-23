//
//  Folder.swift
//  SnippetBox
//
//  Created by Karin Prater on 22.06.23.
//
//

import Foundation
import SwiftData


@Model final public class Folder {
    
    @Attribute(originalName: "creationDate_")
    var creationDate: Date
    
    @Attribute(originalName: "name_")
    var name: String
    
    @Attribute(originalName: "uuid_")
    var uuid: UUID
    
    // array - but data is not keeping sort order
    @Relationship(deleteRule: .cascade, inverse: \Snippet.folder) var snippets: [Snippet]
  
    //MARK: - Init
    
    init(name: String = "",
         snippets: [Snippet] = []) {
        self.creationDate = Date()
        self.uuid = UUID()
        
        self.name = name
        self.snippets = snippets
    }

    static func delete(_ folder: Folder) {
        if let context = folder.modelContext {
            context.delete(folder)
        }
    }
    
    static func example() -> Folder {
        return Folder(name: "test folder")
    }
    
    static func exampleWithSnippets() -> Folder {
        let folder = Folder(name: "test folder")
        folder.snippets.append(Snippet.example())
        return folder
    }
}
