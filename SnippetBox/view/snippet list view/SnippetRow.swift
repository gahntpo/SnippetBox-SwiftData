//
//  SnippetRow.swift
//  SnippetBox
//
//  Created by Karin Prater on 29.06.23.
//

import SwiftUI

struct SnippetRow: View {
    let snippet: Snippet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(snippet.title)
                
                Spacer()
                
                if snippet.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            
            Text(snippet.creationDate, format: .dateTime)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ModelPreview { snippet in
        NavigationStack {
            SnippetRow(snippet: snippet)
        }
    }
}

