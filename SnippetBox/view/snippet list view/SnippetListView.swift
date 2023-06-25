//
//  SnippetListView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import SwiftData

struct SnippetListView: View {
    
    let folder: Folder
    
    @Query(sort: \.creationDate, order: .forward)
    var snippets: [Snippet]
    
    @Binding var selectedSnippet: Snippet?
    
    init(for folder: Folder, selectedSnippet: Binding<Snippet?>) {
      
      //  self._snippets = Query(filter: #Predicate { $0.folder == folder })

        
        self.folder = folder
        self._selectedSnippet = selectedSnippet
    }
    
    var body: some View {
        List(selection: $selectedSnippet) {
            ForEach(folder.snippets) { snippet in
           // ForEach(snippets) { snippet in
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
                .tag(snippet)
            }
           
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: addItem) {
                    Label("Add Snippet", systemImage: "note.text.badge.plus")
                }
            }
        }
        .navigationTitle(folder.name)
    }
    
    private func addItem() {
        withAnimation {
            if let context = folder.context {
                let snippet = Snippet(title: "new snippet")
                snippet.folder = folder
                selectedSnippet = snippet
            }

        }
    }
}

struct SnippetListView_Previews: PreviewProvider {
    static var previews: some View {
        return SnippetListView(for: Folder.exampleWithSnippets(),
                               selectedSnippet: .constant(nil))
    }
}
