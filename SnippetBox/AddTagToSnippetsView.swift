//
//  AddTagToSnippetsView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI

struct AddTagToSnippetsView: View {
    
    let snippet: Snippet
    
    @State private var searchTerm: String = ""
    @FetchRequest(fetchRequest: Tag.fetch(.all)) var tags
    
    @State private var selectedTags = Set<Tag>()
    
    @Environment(\.managedObjectContext) var context
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
                
            List(selection: $selectedTags) {
                ForEach(tags) { tag in
                    
                    HStack {
                        Image(systemName: "tag.fill")
                            .foregroundColor(tag.color)
                        Text(tag.name)
                    }
                    .tag(tag)
                }
            }
            .listStyle(.plain)
            .frame(minHeight: 150)
            
            if selectedTags.count > 0 {
                Button {
                    selectedTags.forEach { tag in
                        snippet.tags.insert(tag)
                    }
                    dismiss()
                } label: {
                    Text("Add keywords to note")
                }
            } else if tags.count == 0 {
                NewTagView(snippet: snippet, searchTerm: searchTerm)
             //  NewKeywordView(note: note,
             //                 searchTerm: searchTerm)
            }
        
        }
        .padding()
        .onChange(of: searchTerm) { newValue in
            
            if newValue.count > 0 {
                tags.nsPredicate = NSPredicate(format: "%K CONTAINS[cd] %@",
                                               TagProperties.name,
                                               searchTerm as CVarArg)
            } else {
                tags.nsPredicate = nil
            }
        }
    }
}

struct AddTagToSnippetsView_Previews: PreviewProvider {
    static var previews: some View {
        AddTagToSnippetsView(snippet: Snippet.example(context: PersistenceController.preview.container.viewContext))
    }
}
