//
//  TagSorting.swift
//  SnippetBox
//
//  Created by Karin Prater on 30.06.23.
//

import Foundation

enum TagSorting: String, Identifiable, CaseIterable {
    case aToZ
    case ztoA
    case latest
    case oldest
    
    var title: String {
        switch self {
            case .aToZ:
                return "A to Z"
            case .ztoA:
                return "Z to A"
            case .latest:
                return "Latest"
            case .oldest:
                return "Oldest"
        }
    }
    
    var sortDescriptor: SortDescriptor<Tag> {
        switch self {
            case .aToZ:
                SortDescriptor(\Tag.name, order: .forward)
            case .ztoA:
                SortDescriptor(\Tag.name, order: .reverse)
            case .latest:
                SortDescriptor(\Tag.creationDate, order: .reverse)
            case .oldest:
                SortDescriptor(\Tag.creationDate, order: .forward)
        }
       
    }
    
    var id: Self { return self }
}
