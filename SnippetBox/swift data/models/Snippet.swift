//
//  Snippet.swift
//  SnippetBox
//
//  Created by Karin Prater on 23.06.23.
//
//

import SwiftUI
import SwiftData
import CodeEditor

@Model final public class Snippet {
    
    @Attribute(originalName: "uuid_")
    let uuid: UUID
    
    @Attribute(originalName: "creationDate_")
    let creationDate: Date
    
    @Attribute(originalName: "code_")
    var code: String

    @Attribute(.externalStorage)
    var image: Data?      
    
    var isFavorite: Bool
    
    @Attribute(originalName: "notes_")
    var notes: String
    
    @Attribute(originalName: "title_")
    var title: String
    
    var folder: Folder?     // to-one relationships is always optional
  
    @Relationship(inverse: \Tag.snippets)
    var tags: [Tag] // relationships only works with optional
    
    var codingLanguageData: CodingLanguage

    //MARK: - Init
    
    init(
        code: String = "",
        image: Data? = nil,
        isFavorite: Bool = false,
        language: CodingLanguage = .swift,
        notes: String = "",
        title: String = "",
        folder: Folder? = nil,
        tags: [Tag] = [],
        creationDate: Date = Date()
    ) {
        self.creationDate = creationDate
        self.uuid = UUID()
        self.image = image
        self.code = code
        self.isFavorite = isFavorite
        self.codingLanguageData = language
        self.notes = notes
        self.title = title
        
        self.folder = folder
        self.tags = tags
    }
    
    static func delete(_ snippet: Snippet) {
        if let context = snippet.modelContext {
            context.delete(snippet)
            //try? context.save() // suggested fix
        }
    }
    
    static func createImage(from imageData: Data) async -> UIImage? {
        let image = await Task(priority: .background) {
            UIImage(data: imageData)
        }.value
        
        return image
    }
    
    func createFullImage() async -> UIImage? {
        guard let data = image else { return nil }
        let image = await Snippet.createImage(from: data)
        print("create image")
        return image
    }
    
    // MARK: - preview
    
    static var preview: Snippet = {
        let snippet = Snippet(code: "test code", title: "snippet title")
        //Task { @MainActor in
        //    previewContainer.mainContext.insert(snippet)
       // }
        return snippet
    }()
    
    static func example() -> Snippet {
        let snippet = Snippet(title: "My test snippet")
        snippet.codingLanguageData = .swift
        snippet.code = """
                   List {
                   ForEach(items) { item in
                       NavigationLink {
                           Text("Item")
                       } label: {
                           Text(item.timestamp!, formatter: itemFormatter)
                       }
                   }
                   .onDelete(perform: deleteItems)
                 }
                 """
        
      // this will crash the preview which does not work currently with relationships:
      //  snippet.tags.append(Tag.example())
      //  snippet.tags.append(Tag.example2())
      //  snippet.tags.append(Tag.example3())
        
        return snippet
    }
    
    static func example2() -> Snippet {
        let snippet = Snippet(title: "My favorite snippet")
        snippet.codingLanguageData = .typescript
        snippet.isFavorite = true
        return snippet
    }
    
    
    static func example3() -> Snippet {
        let snippet = Snippet(title: "Old snippet", creationDate: Date() - 1000)
        snippet.codingLanguageData = .objectivec
        snippet.isFavorite = true
        return snippet
    }
    
    static func example4() -> Snippet {
        let snippet = Snippet(title: "snippet from yesterday", creationDate: Date() - 100000)
        snippet.codingLanguageData = .pyton
        return snippet
    }
}

extension Snippet: Comparable {
    public static func < (lhs: Snippet, rhs: Snippet) -> Bool {
        lhs.creationDate < rhs.creationDate
    }
}




