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
    
    @Relationship( inverse: \Tag.snippets_)
    var tags_: [Tag]? = nil // relationships only works with optional
    
    var tags: [Tag] {
        get { self.tags_ ?? [] }
        set { self.tags_ = newValue  }
    }
    
    var language_: String?
    
    //var codingLanguage: CodeEditor.Language = .swift
    
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
    
    //MARK: - Init
    
    init(
        code: String = "",
        image: Data? = nil,
        isFavorite: Bool = false,
        language_: String? = CodeEditor.Language.swift.rawValue,
        notes: String = "",
        title: String = "",
        folder: Folder? = nil,
        tags_: [Tag] = [],
        creationDate: Date = Date()
    ) {
        self.creationDate = creationDate
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
    
    static func delete(_ snippet: Snippet) {
        if let context = snippet.context {
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
        
      // this will crash the preview which does not work currently with relationships:
      //  snippet.tags.append(Tag.example())
      //  snippet.tags.append(Tag.example2())
      //  snippet.tags.append(Tag.example3())
        
        return snippet
    }
    
    static func example2() -> Snippet {
        let snippet = Snippet(title: "My favorite snippet")
        snippet.language_ = CodeEditor.Language.http.rawValue
        snippet.isFavorite = true
        return snippet
    }
    
    
    static func example3() -> Snippet {
        let snippet = Snippet(title: "Old snippet", creationDate: Date() - 1000)
        snippet.language_ = CodeEditor.Language.swift.rawValue
        snippet.isFavorite = true
        return snippet
    }
    
    static func example4() -> Snippet {
        let snippet = Snippet(title: "snippet from yesterday", creationDate: Date() - 100000)
        snippet.language_ = CodeEditor.Language.http.rawValue
        return snippet
    }
}

extension Snippet: Comparable {
    public static func < (lhs: Snippet, rhs: Snippet) -> Bool {
        lhs.creationDate < rhs.creationDate
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


