//
//  FolderSnippetExample.swift
//  SnippetBox
//
//  Created by Karin Prater on 03.07.23.
//

/*
 
 Problem with Query in Preview
 does not work for relationships
 
 */

import SwiftUI
import SwiftData

struct RelationshipPredicateSnippetListExample: View {
    @Query(sort: [SortDescriptor(\Snippet.creationDate)] )
    var allSnippets: [Snippet]
    
    @Query(filter: #Predicate<Snippet> { $0.folder == nil },
             sort: [SortDescriptor(\.creationDate)] )
    var nofolderSnippets: [Snippet]
    
    @Query(filter: #Predicate<Snippet> { $0.folder?.name == "new folder" },
             sort: [SortDescriptor(\.creationDate)] )
    var newFolderSnippets: [Snippet]
    
    
    @Query(filter: #Predicate<Snippet> { !$0.tags.isEmpty },
             sort: [SortDescriptor(\.creationDate)] )
    var tagsSnippets: [Snippet]
    
    
    var body: some View {
        List {
            Section("All Snippets") {
                ForEach(allSnippets){ snippet in
                    DetailedRelationshipSnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets without folder") {
                ForEach(nofolderSnippets){ snippet in
                    DetailedRelationshipSnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets in folder with name ´new folder´") {
                ForEach(newFolderSnippets){ snippet in
                    DetailedRelationshipSnippetRow(snippet: snippet)
                }
            }
            
            Section("Snippets with tags") {
                ForEach(tagsSnippets){ snippet in
                    DetailedRelationshipSnippetRow(snippet: snippet)
                }
            }
        }
    }
}



#Preview {
    RelationshipPredicateSnippetListExample()
        .modelContainer(previewContainer)
}
