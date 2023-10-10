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
    
    /*
    @Query(filter: #Predicate { $0.isFavorite && $0.codingLanguageData.rawValue == 1 },
             sort: [SortDescriptor(\Snippet.creationDate)] )
    var snippets: [Snippet]
    
    @Query(filter: #Predicate<Snippet> { $0.isFavorite || $0.codingLanguageData.rawValue == 1  },
             sort: [SortDescriptor(\.creationDate)] )
    var orSnippets: [Snippet]
     */
    
    @Query(filter: #Predicate { !$0.isFavorite && $0.code.contains("List") },
             sort: [SortDescriptor(\Snippet.creationDate)] )
    var snippets: [Snippet]
    
    @Query(filter: #Predicate { $0.isFavorite || $0.code.contains("List") },
           sort: [SortDescriptor(\Snippet.creationDate)] )
    var orSnippets: [Snippet]
    
    var body: some View {
        List {
            Section("All Snippets") {
                ForEach(allSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets that are not favorite and code contains `List`:") {
                ForEach(snippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets that are either favorite or their cod contains `List`") {
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
