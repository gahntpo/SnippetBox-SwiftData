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
    @Relationship(.cascade, inverse: \Snippet.folder) var snippets_: [Snippet]?
    
    var snippets: [Snippet] {
        get { self.snippets_ ?? [] }
        set { self.snippets_ = newValue  }
    }
    
    //MARK: - Init
    
    init(name: String = "",
         snippets: [Snippet] = []) {
        self.creationDate = Date()
        self.uuid = UUID()
        
        self.name = name
        self.snippets = snippets
    }

    static func delete(_ folder: Folder) {
        if let context = folder.context {
            context.delete(folder)
        }
    }
    
    static var exampleContext: ModelContext = {
        let schema = Schema([Folder.self, Snippet.self, Tag.self])
        let configuration = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        return ModelContext(container)
    }()
    
    static func example() -> Folder {
        let folder = Folder(name: "test folder")
       let context = Folder.exampleContext
        context.insert(folder)
        
        return folder
    }
    
    static func exampleWithSnippets() -> Folder {
        let folder = Folder(name: "test folder")
        folder.snippets.append(Snippet.example())
        return folder
    }
}
