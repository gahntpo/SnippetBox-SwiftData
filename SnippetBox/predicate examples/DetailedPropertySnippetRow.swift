//
//  DetailedSnippetRow.swift
//  SnippetBox
//
//  Created by Karin Prater on 03.07.23.
//

import SwiftUI

struct DetailedPropertySnippetRow: View {
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
            
            HStack {
                Text(snippet.creationDate, format: .dateTime)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                
                Text(snippet.codingLanguageData.title)
                    .textCase(.uppercase)
                    .bold()
                
                if snippet.image != nil {
                    Image(systemName: "photo")
                }
            }
            
            if !snippet.code.isEmpty {
                Text(snippet.code)
                    .lineLimit(2)
                    .italic()
            } 
        }
    }
}

#Preview {
    ModelPreview { snippet in
        DetailedPropertySnippetRow(snippet: snippet)
            .padding()
    }
}
