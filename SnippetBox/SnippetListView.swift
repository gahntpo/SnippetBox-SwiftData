//
//  SnippetListView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI

struct SnippetListView: View {
    
    let folder: Folder
    @FetchRequest(fetchRequest: Snippet.fetch(.none)) private var snippets: FetchedResults<Snippet>
    @Binding var selectedSnippet: Snippet?
    
    init(for folder: Folder, selectedSnippet: Binding<Snippet?>) {
        let request = Snippet.fetchSnippets(for: folder)
        self._snippets = FetchRequest(fetchRequest: request)
        
        self.folder = folder
        self._selectedSnippet = selectedSnippet
    }
    
    var body: some View {
        List(selection: $selectedSnippet) {
            ForEach(snippets) { snippet in
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
    }
    
    private func addItem() {
        withAnimation {
            if let context = folder.managedObjectContext {
                let snippet = Snippet(title: "new snippet", context: context)
                snippet.folder = folder
                selectedSnippet = snippet
            }

            PersistenceController.shared.save()
        }
    }
}

struct SnippetListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let folder = Folder.exampleWithSnippets(context: context)
        return SnippetListView(for: folder, selectedSnippet: .constant(nil))
    }
}
