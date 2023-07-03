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
    
    @Query(sort: \.creationDate, order: .reverse)
    var snippets: [Snippet]
    
    @Binding var selectedSnippet: Snippet?
    
    init(for folder: Folder, selectedSnippet: Binding<Snippet?>) {
      
        // does not work, uuid not supported with Xcode 15 beta 2
        // #Predicate does not support UUID, Date, and URL properties. (109539652)
        /*
        
        self._snippets = Query(filter: #Predicate {
         $0.folder?.id == folder.id
         // $0.folder == folder
     }, sort: \.creationDate)
        */
        
        self.folder = folder
        self._selectedSnippet = selectedSnippet
    }
    
    var body: some View {
        
        List(selection: $selectedSnippet) {
            ForEach(folder.snippets.sorted()) { snippet in
           // ForEach(snippets) { snippet in
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
    @Query(sort: \.creationDate, order: .forward)
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
