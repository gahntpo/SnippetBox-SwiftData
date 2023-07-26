//
//  MultiPropertPredicateSnippetListExample.swift
//  SnippetBox
//
//  Created by Karin Prater on 03.07.23.
//

import SwiftUI
import SwiftData

struct MultiPropertPredicateSnippetListExample: View {
    
    @Query(sort: [SortDescriptor(\Snippet.creationDate)] )
    var allSnippets: [Snippet]
    
    @Query(filter: #Predicate { $0.isFavorite && $0.language_ == "swift" },
             sort: [SortDescriptor(\Snippet.creationDate)] )
    var snippets: [Snippet]
    
    @Query(filter: #Predicate<Snippet> { $0.isFavorite || $0.language_ == "swift" },
             sort: [SortDescriptor(\.creationDate)] )
    var orSnippets: [Snippet]
    
    var body: some View {
        List {
            Section("All Snippets") {
                ForEach(allSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets that are favorite and swift:") {
                ForEach(snippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets that are favorite and swift:") {
                ForEach(orSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
        }
    }
}

#Preview {
    MultiPropertPredicateSnippetListExample()
        .modelContainer(previewContainer)
}
