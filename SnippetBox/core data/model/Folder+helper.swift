//
//  Folder+Helper.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import Foundation
import CoreData

extension Folder {
    
    var uuid: UUID {
        #if DEBUG
        return uuid_!
        #else
        return uuid_ ?? UUID()
        #endif
    }
    
    var name: String {
        get { name_ ?? "" }
        set { name_ = newValue }
    }
    
    var creationDate: Date {
        get { creationDate_ ?? Date() }
    }
    
    var snippets: Set<Snippet> {
        get { (snippets_ as? Set<Snippet>) ?? [] }
        set { snippets_ = newValue as NSSet }
    }
    
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
    }
    
    public override func awakeFromInsert() {
        self.creationDate_ = Date()
        self.uuid_ = UUID()
    }
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Folder> {
        let request = Folder.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Folder.creationDate_,
                                                    ascending: true)]
       // request.fetchBatchSize = 10
        request.predicate = predicate
        
        return request
    }
    
    static func delete(_ folder: Folder) {
        guard let context = folder.managedObjectContext else { return }
        context.delete(folder)
    }
    
    static func exampleWithSnippets(context: NSManagedObjectContext) -> Folder {
        let folder = Folder(name: "my folder", context: context)
        
        let snippet = Snippet.example(context: context)
        folder.snippets.insert(snippet)
        return folder
    }
}


extension Folder: Comparable {
    public static func < (lhs: Folder, rhs: Folder) -> Bool {
        lhs.creationDate < rhs.creationDate
    }
}
