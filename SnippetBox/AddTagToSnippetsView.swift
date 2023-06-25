//
//  AddTagToSnippetsView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import SwiftData

struct AddTagToSnippetsView: View {
    
    let snippet: Snippet
    
    @State private var searchTerm: String = ""
    
    @Query(sort: \.creationDate, order: .forward)
    var tags: [Tag]
    
    
    @State private var selectedTags = Set<Tag>()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Add tags to ")
                Text(snippet.title).bold()
            }
            
            HStack {
                TextField("search", text: $searchTerm)
                    .textFieldStyle(.roundedBorder)
                
                if searchTerm.count > 0 {
                    Button {
                        searchTerm = ""
                    } label: {
                        Text("clear")
                    }
                    .foregroundColor(.pink)
                }
            }
                
            
            TagListView(searchTerm: searchTerm, selectedTags: $selectedTags, snippet: snippet)
        
        }
        .padding()
        .onChange(of: searchTerm) { newValue in
            
            if newValue.count > 0 {
                //tags.nsPredicate = NSPredicate(format: "%K CONTAINS[cd] %@",
                //                               TagProperties.name,
                //                               searchTerm as CVarArg)
            } else {
               // tags.nsPredicate = nil
            }
        }
    }
}

struct AddTagToSnippetsView_Previews: PreviewProvider {
    static var previews: some View {
        AddTagToSnippetsView(snippet: Snippet.example())
    }
}
