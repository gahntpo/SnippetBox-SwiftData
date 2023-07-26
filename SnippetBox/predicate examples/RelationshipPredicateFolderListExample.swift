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
    
    /*
    @Query(filter: #Predicate { $0.snippets.count > 0  },
           sort: [SortDescriptor(\.creationDate)] )
    var snippetFolders: [Folder]
    
    @Query(filter: #Predicate {
        $0.snippets.contains {
            $0.isFavorite
        }
    },
        sort: [SortDescriptor(\.creationDate)] )
    var someFavoriteSnippetFolders: [Folder]
    
    @Query(filter: #Predicate {
        $0.snippets.allSatisfy {
            $0.isFavorite
        }
    },
        sort: [SortDescriptor(\.creationDate)] )
    var allFavoriteSnippetFolders: [Folder]
    */
    
    var body: some View {
        List {
            Section("all folders") {
                ForEach(allFolders){ folder in
                    Label(folder.name, systemImage: "folder")
                        .badge(folder.snippets.count)
                }
            }
            /*
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
             */
        }
    }
}

#Preview {
    RelationshipPredicateFolderListExample()
}
