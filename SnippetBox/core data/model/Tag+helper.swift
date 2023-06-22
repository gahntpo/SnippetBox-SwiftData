//
//  Tag+helper.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import CoreData

extension Tag {
    
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
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Tag> {
        let request = Tag.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.creationDate_,
                                                    ascending: true)]
       // request.fetchBatchSize = 10
        request.predicate = predicate
        
        return request
    }
    
    static func delete(_ tag: Tag) {
        guard let context = tag.managedObjectContext else { return }
        context.delete(tag)
    }
    
    static func example(context: NSManagedObjectContext) -> Tag {
        let tag = Tag(name: "my tag", context: context)
        tag.color = Color(red: 0.9, green: 0, blue: 0)
        return tag
    }
    
    static func example2(context: NSManagedObjectContext) -> Tag {
        let tag = Tag(name: "my very long tag", context: context)
        tag.color = Color(red: 0, green: 1, blue: 1)
        return tag
    }
    
    static func example3(context: NSManagedObjectContext) -> Tag {
        let tag = Tag(name: "something awesome", context: context)
        tag.color = Color(red: 0.5, green: 1, blue: 0.9)
        return tag
    }
}

extension Tag: Comparable {
    public static func < (lhs: Tag, rhs: Tag) -> Bool {
        lhs.creationDate < rhs.creationDate
    }
}


//MARK: - define my string constants

struct TagProperties {
    
    static let uuid = "uuid_"
    
    static let name = "name_"
    static let snippets = "snippets_"
}
