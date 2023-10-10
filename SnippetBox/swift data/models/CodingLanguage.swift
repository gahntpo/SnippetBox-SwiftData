//
//  CodingLanguage.swift
//  SnippetBox
//
//  Created by Karin Prater on 10.10.23.
//

import Foundation

enum CodingLanguage: Int, Codable, CaseIterable, Identifiable {
    case swift = 0
    case objectivec
    case pyton
    case css
    case typescript
    
    var id: Self { return self }
    
    var title: String {
        switch self {
            case .swift:
                return "swift"
            case .objectivec:
                return "objective-c"
            case .pyton:
                return "python"
            case .css:
                return "css"
            case .typescript:
                return "typescript"
        }
    }
}
