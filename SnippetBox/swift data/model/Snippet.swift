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
    
    @Attribute(originalName: "code_")
    var code: String
    
    @Attribute(originalName: "creationDate_")
    var creationDate: Date
    
    @Attribute(originalName: "uuid_")
    var uuid: UUID
    
    @Attribute(.externalStorage) var image: Data?
    var isFavorite: Bool
    
    var language_: String?
    
   // @Attribute(.transformable)
    //var codingLanguage: CodeEditor.Language = .swift
    
    @Attribute(originalName: "notes_")
    var notes: String
    
    @Attribute(originalName: "title_")
    var title: String
    
    var folder: Folder?
    
    var tags_: [Tag]? = nil
    
    init(
        code: String = "",
        image: Data? = nil,
        isFavorite: Bool = false,
        language_: String? = nil,
        notes: String = "",
        title: String = "",
        folder: Folder? = nil,
        tags_: [Tag] = []
    ) {
        self.creationDate = Date()
        self.uuid = UUID()
        self.image = image
        self.code = code
        self.isFavorite = isFavorite
        self.language_ = language_
        self.notes = notes
        self.title = title
        
        self.folder = folder
        self.tags = tags
    }
    
    var language: CodeEditor.Language {
        get {
            if let language_ = language_ {
               return CodeEditor.Language.init(rawValue: language_)
            } else {
                return .swift
            }
        }
        set { self.language_ = newValue.rawValue  }
    }
    
    var tags: [Tag] {
        get { self.tags_ ?? [] }
        set { self.tags_ = newValue  }
    }
    
    static func delete(_ snippet: Snippet) {
        if let context = snippet.context {
            context.delete(snippet)
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
    
    static func example() -> Snippet {
        let snippet = Snippet(title: "New snippet")
        snippet.language_ = CodeEditor.Language.swift.rawValue
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
        
        snippet.tags.append(Tag.example())
        snippet.tags.append(Tag.example2())
        snippet.tags.append(Tag.example3())
        
        return snippet
    }
    
}


enum CodingLanguage: String, Codable, CaseIterable, Identifiable {
    case swift
    case objectivec
    case pyton
    case css
    case typescript
    
    var id: Self { return self }
}
