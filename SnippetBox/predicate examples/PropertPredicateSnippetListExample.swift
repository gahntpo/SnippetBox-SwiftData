//
//  FavoriteSnippetListExample.swift
//  SnippetBox
//
//  Created by Karin Prater on 03.07.23.
//

import SwiftUI
import SwiftData

struct PropertPredicateSnippetListExample: View {
    
    @Query(sort: [SortDescriptor(\.creationDate)] )
    var allSnippets: [Snippet]
    
    @Query(filter: #Predicate { $0.isFavorite },
             sort: [SortDescriptor(\.creationDate)] )
    var snippets: [Snippet]

    @Query(filter: #Predicate { $0.language_ == "swift" },
             sort: [SortDescriptor(\.creationDate)] )
    var swiftSnippets: [Snippet]
    
    @Query(filter: #Predicate { $0.title.contains("test") },
             sort: [SortDescriptor(\.creationDate)] )
    var searchTermSnippets: [Snippet]

    @Query(filter: #Predicate { $0.code.count > 0 },
             sort: [SortDescriptor(\.creationDate)] )
    var longCodeSnippets: [Snippet]
    
    @Query(filter: #Predicate { $0.image != nil },
             sort: [SortDescriptor(\.creationDate)] )
    var imageSnippets: [Snippet]
    
    lazy var startOfDay: Date = {
        let now = Date.now
        return now.startOfDay
    }()
    
    @Query(sort: [SortDescriptor(\.creationDate)] )
    var oldSnippets: [Snippet]
    
    init() {
        let now = Date.now
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        // known issue: predicate does not work with Date type
        self._oldSnippets = Query(filter: #Predicate {
            $0.creationDate < now
        }, sort: [SortDescriptor(\.creationDate)])
    }
    
    var body: some View {
        List {
            Section("All Snippets") {
                ForEach(allSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("Favorite Snippets") {
                ForEach(snippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("Swift Snippets") {
                ForEach(swiftSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("search for test in Snippet title:") {
                ForEach(searchTermSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets with code") {
                ForEach(longCodeSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets with an image") {
                ForEach(imageSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }

            // date not working
            Section("Old Snippets (before today)") {
                ForEach(oldSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }

        }
    }
}


extension Date {

    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}

#Preview {
    PropertPredicateSnippetListExample()
        .modelContainer(previewContainer)
}

