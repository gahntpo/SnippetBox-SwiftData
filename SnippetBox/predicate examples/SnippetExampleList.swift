//
//  SnippetExampleList.swift
//  SnippetBox
//
//  Created by Karin Prater on 03.07.23.
//

import SwiftUI
import SwiftData

struct SnippetExampleList: View {
    
    @Query(sort: [SortDescriptor(\Snippet.creationDate)] )
    var allSnippets: [Snippet]
    
    var body: some View {
        List {
            Section("All Snippets") {
                ForEach(allSnippets){ snippet in
                    DetailedPropertySnippetRow(snippet: snippet)
                }
            }
        }
    }
}

#Preview {
    SnippetExampleList()
        .modelContainer(previewContainer)
}
