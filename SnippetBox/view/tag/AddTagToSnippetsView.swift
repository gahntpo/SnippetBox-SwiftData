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
  
    @State private var selectedTags = Set<Tag>()
    @State private var tagSorting = TagSorting.aToZ
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            TagListView(searchTerm: searchTerm,
                        sorting: tagSorting,
                        selectedTags: $selectedTags,
                        snippet: snippet)
            .padding(.horizontal)
            .navigationTitle("Add tags to \(snippet.title)")
             #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            
            .searchable(text: $searchTerm)
            .toolbar(content: {
                Menu {
                    Picker(selection: $tagSorting) {
                        ForEach(TagSorting.allCases) { tag in
                            Text(tag.title)
                        }
                    } label: {
                        Text("Sort Tags by")
                    }
                    
                } label: {
                    Label("Sorting", systemImage: "slider.horizontal.3")
                }
                
            })
        }
        .frame(minWidth: 300, minHeight: 300)
    }
}

#Preview {
    ModelPreview { snippet in
        NavigationView(content: {
            AddTagToSnippetsView(snippet: snippet)
        })
       
    }
}
