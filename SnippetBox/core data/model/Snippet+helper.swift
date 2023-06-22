//
//  Snippet+helper.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import CoreData
import CodeEditor

extension Snippet {
    
    var uuid: UUID {
#if DEBUG
        return uuid_!
#else
        return uuid_ ?? UUID()
#endif
    }
    
    var title: String {
        get { self.title_ ?? "" }
        set { self.title_ = newValue  }
    }
    
    var code: String {
        get { self.code_ ?? "" }
        set { self.code_ = newValue  }
    }
    
    var notes: String {
        get { self.notes_ ?? "" }
        set { self.notes_ = newValue  }
    }
    
    var creationDate: Date {
        get { creationDate_ ?? Date() }
    }
    
    var tags: Set<Tag> {
        get { (tags_ as? Set<Tag>) ?? [] }
        set { tags_ = newValue as NSSet }
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
    
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
    }
    
    public override func awakeFromInsert() {
        self.creationDate_ = Date()
        self.uuid_ = UUID()
    }
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Snippet> {
        let request = Snippet.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Snippet.creationDate_,
                                                    ascending: true)]
        request.predicate = predicate
        
        return request
    }
    
    static func fetchSnippets(for folder: Folder) -> NSFetchRequest<Snippet>  {
        let predicate = NSPredicate(format: "folder == %@ ", folder)
        let request = Snippet.fetch(predicate)
        return request
    }
    
    static func delete(_ snippet: Snippet) {
        guard let context = snippet.managedObjectContext else { return }
        context.delete(snippet)
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
    
    static func example(context: NSManagedObjectContext) -> Snippet {
        let snippet = Snippet(title: "New snippet", context: context)
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
        
        snippet.tags.insert(Tag.example(context: context))
        snippet.tags.insert(Tag.example2(context: context))
        snippet.tags.insert(Tag.example3(context: context))
        
        return snippet
    }
    
}

