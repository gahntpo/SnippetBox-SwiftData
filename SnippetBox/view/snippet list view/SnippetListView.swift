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
    
    @Query(sort: \Snippet.creationDate, order: .reverse)
    var snippets: [Snippet]
    
    @Binding var selectedSnippet: Snippet?
    
    init(for folder: Folder, selectedSnippet: Binding<Snippet?>) {

        let id = folder.uuid  // workaround: optional fetch 
        
        self._snippets = Query(filter: #Predicate {
            $0.folder?.uuid == id
        }, sort: \.creationDate)
   
        
        self.folder = folder
        self._selectedSnippet = selectedSnippet
    }
    
    var body: some View {
        
        List(selection: $selectedSnippet) {
           ForEach(snippets) { snippet in
                SnippetRow(snippet: snippet)
                .tag(snippet)
                .swipeActions {
                    Button(role: .destructive) {
                        Snippet.delete(snippet)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                }
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
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addItem() {
        withAnimation {
            let snippet = Snippet(title: "new snippet")
            //snippet.folder = folder
            folder.snippets.append(snippet)
            selectedSnippet = snippet
        }
    }
}

private struct PreviewSnippetListView: View {
    @Query(sort: \Folder.creationDate, order: .forward)
    private var folders: [Folder]
    
    var body: some View {
        SnippetListView(for: folders[0],
                        selectedSnippet: .constant(nil))
    }
}

struct SnippetListView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSnippetListView()
        
      // SnippetListView(for: Folder.exampleWithSnippets(),
      //                         selectedSnippet: .constant(nil))
            .modelContainer(PreviewSampleData.container)
    }
}



