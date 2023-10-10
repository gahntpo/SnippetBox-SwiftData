//
//  DetailedRelationshipSnippetRow.swift
//  SnippetBox
//
//  Created by Karin Prater on 03.07.23.
//

import SwiftUI

struct DetailedRelationshipSnippetRow: View {
    let snippet: Snippet
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(snippet.title)
            
            if let folder = snippet.folder  {
                Label(folder.name, systemImage: "folder")
                    .padding(.leading)
            }
            
            if snippet.tags.count > 0 {
                HStack(alignment: .firstTextBaseline) {
                    Text("Tags:")
                    
                    ForEach(snippet.tags) { tag in
                        TagCell(tag: tag)
                    }
                }
                .padding(.leading)
            }
        }
    }
}

#Preview {
    ModelPreview { snippet in
        DetailedRelationshipSnippetRow(snippet: snippet)
            .padding()
    }
}
