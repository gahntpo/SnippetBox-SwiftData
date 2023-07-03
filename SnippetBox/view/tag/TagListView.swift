//
//  TagListView.swift
//  SnippetBox
//
//  Created by Karin Prater on 24.06.23.
//

import SwiftUI
import SwiftData

struct TagListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: \.name, order: .forward)
    var tags: [Tag]
    
    @Binding var selectedTags: Set<Tag>
    let snippet: Snippet
    let searchTerm: String
    
    init(searchTerm: String,
         sorting: TagSorting,
         selectedTags: Binding<Set<Tag>>,
         snippet: Snippet) {
        self._selectedTags = selectedTags
        self.snippet = snippet
        self.searchTerm = searchTerm
        
        if searchTerm.count > 0 {
            self._tags = Query(filter: #Predicate {
                $0.name.contains(searchTerm)
            }, sort: [sorting.sortDescriptor])
            
        } else {
            self._tags = Query(sort: [sorting.sortDescriptor])
        }
    }
    
    var body: some View {
        List(selection: $selectedTags) {
            ForEach(tags) { tag in
                HStack {
                    Image(systemName: "tag.fill")
                        .foregroundColor(tag.color)
                    Text(tag.name)
                    
                    Spacer()
                    
                    Text(String(tag.snippets.count))
                }
                .tag(tag)
            }
        }
        .listStyle(.plain)
        .frame(minHeight: 150)
        
        if selectedTags.count > 0 {
            Button {
                selectedTags.forEach { tag in
                    snippet.tags.append(tag)
                }
                dismiss()
            } label: {
                Text("Add keywords to note")
            }
        } else if tags.count == 0 {
            NewTagView(snippet: snippet,
                       searchTerm: searchTerm)
        }
        
    }
}

#Preview {
    ModelPreview { snippet in
        VStack {
            TagListView(searchTerm: "",
                        sorting: .aToZ,
                        selectedTags: .constant([]),
                        snippet: snippet)
        }
    }
}

#Preview("without search results") {
    ModelPreview { snippet in
        VStack {
            TagListView(searchTerm: "test",
                        sorting: .aToZ,
                        selectedTags: .constant([]),
                        snippet: snippet)
        }
    }
}


/*
 struct TagListView_Previews: PreviewProvider {
 static var previews: some View {
 VStack {
 TagListView(searchTerm: "test", selectedTags: .constant([]), snippet: Snippet.example())
 }
 .modelContainer(PreviewSampleData.container)
 }
 }
 */
