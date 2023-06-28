//
//  FolderListView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import SwiftData

struct FolderListView: View {
    
    @Environment(\.modelContext) private var context

    @Query(sort: \.creationDate, order: .forward)
    var folders: [Folder]

    @Binding var selectedFolder: Folder?
    
    var body: some View {
        List(selection: $selectedFolder) {
 
                ForEach(folders) { folder in
                    NavigationLink(value: folder) {
                        FolderRow(folder: folder, selectedFolder: selectedFolder)
                    }
                }
                .onDelete(perform: deleteItems)
            
        }
        .navigationTitle("Folders")
        .toolbar {
#if os(iOS)
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
#endif
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Folder", systemImage: "folder.badge.plus")
                }
            }
        }
    }
    
    
    private func addItem() {
        withAnimation {
            let folder = Folder(name: "new folder")
            context.insert(object: folder)
            selectedFolder = folder
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            
            offsets.map { folders[$0] }.forEach { context.delete($0) }

        }
    }
}

// working solutions for preview:

/*
#Preview {
    NavigationView {
        FolderListView(selectedFolder: .constant(nil))
    }
    .modelContainer(previewContainer)
}
 */

#Preview {
    MainActor.assumeIsolated {
        NavigationView {
            FolderListView(selectedFolder: .constant(nil))
        }
        .modelContainer(PreviewSampleData.container)
    }
}

/*
struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FolderListView(selectedFolder: .constant(nil))
        }
        .modelContainer(PreviewSampleData.container)
    }
}
*/

