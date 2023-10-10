//
//  RelationshipPredicateFolderListExample.swift
//  SnippetBox
//
//  Created by Karin Prater on 04.07.23.
//

import SwiftUI
import SwiftData

struct RelationshipPredicateFolderListExample: View {
    
    @Query(sort: \Folder.name) var allFolders: [Folder]
    
    
    @Query(filter: #Predicate<Folder> { !$0.snippets.isEmpty  },
           sort: [SortDescriptor(\Folder.creationDate)] )
    var snippetFolders: [Folder]
    
     
    @Query(filter: #Predicate<Folder> {
        $0.snippets.contains {
            $0.isFavorite
        }
    },
        sort: [SortDescriptor(\Folder.creationDate)] )
    var someFavoriteSnippetFolders: [Folder]
    
    @Query(filter: #Predicate<Folder> {
        $0.snippets.allSatisfy {
            $0.isFavorite
        } && !$0.snippets.isEmpty
    },
        sort: [SortDescriptor(\Folder.creationDate)] )
    var allFavoriteSnippetFolders: [Folder]
    
    
    var body: some View {
        List {
            Section("all folders") {
                ForEach(allFolders){ folder in
                    Label(folder.name, systemImage: "folder")
                        .badge(folder.snippets.count)
                    
                    ForEach(folder.snippets) {
                        TestSnippetRow(snippet: $0)
                            .padding(.leading, 30)
                    }
                }
            }
            
            Section("folders with snippets") {
                ForEach(snippetFolders){ folder in
                    Label(folder.name, systemImage: "folder")
                        .badge(folder.snippets.count)
                }
            }
            
            Section("folder with any snippet that are favorite") {
                ForEach(someFavoriteSnippetFolders){ folder in
                    Text(folder.name)
                }
            }
            
            Section("folder with all snippet favorite") {
                ForEach(allFavoriteSnippetFolders){ folder in
                    Text(folder.name)
                }
            }
             
        }
    }
}

private struct TestSnippetRow: View {
    let snippet: Snippet
    
    var body: some View {
        HStack {
            Image(systemName: "note")
            Text(snippet.title)
            
            Spacer()
            
            if snippet.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}


#Preview {
    RelationshipPredicateFolderListExample()
        .modelContainer(previewContainer)
}


