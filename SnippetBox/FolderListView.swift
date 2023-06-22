//
//  FolderListView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI

struct FolderListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Folder.fetch(.all))
    private var folders: FetchedResults<Folder>

    @Binding var selectedFolder: Folder?
    
    var body: some View {
        List(selection: $selectedFolder) {
            Section("Folders") {
                ForEach(folders) { folder in
                    NavigationLink(value: folder) {
                        FolderRow(folder: folder, selectedFolder: selectedFolder)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
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
            let folder = Folder(name: "new folder", context: viewContext)
            selectedFolder = folder
            PersistenceController.shared.save()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { folders[$0] }.forEach(viewContext.delete)

            PersistenceController.shared.save()
        }
    }
}

struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView(selectedFolder: .constant(nil))
    }
}
