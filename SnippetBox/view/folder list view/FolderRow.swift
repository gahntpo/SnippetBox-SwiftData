//
//  FolderRow.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import SwiftData

struct FolderRow: View {
    var folder: Folder
    let selectedFolder: Folder?
    
    @FocusState private var textFieldIsSelected: Bool
    @State private var showRenameEditor: Bool = false
    
    var folderColor: Color {
        selectedFolder == folder ? Color.white : Color.accentColor
    }
    
    var body: some View {
        HStack {
#if os(iOS)
            Label(folder.name, systemImage: "folder")
                .badge(folder.snippets.count)
            
#else
            Image(systemName: "folder")
               // .foregroundColor(folderColor)
                //.foregroundStyle(folderColor)
            TextField("name", text: $folder.name)
                .focused($textFieldIsSelected)
            Spacer()
            Text("\(folder.snippets.count)")
                .foregroundColor(.secondary)
#endif

        }
        .swipeActions {
            
            Button(role: .destructive) {
                Folder.delete(folder)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            Button(action: {
                startRenameAction()
            }, label: {
                Label("Rename", systemImage: "pencil")
            })
            
        }
        .contextMenu {
            
            Button("Rename") {
                startRenameAction()
            }
            Button("Delete") {
                Folder.delete(folder)
            }
        }
        .sheet(isPresented: $showRenameEditor, content: {
            FolderEditorView(folder: folder)
        })

    }
    
    func startRenameAction() {
        #if os(OSX)
        textFieldIsSelected = true
        #else
        showRenameEditor = true
        #endif
    }
}

#Preview {
    ModelPreview { folder in
        FolderRow(folder: folder, selectedFolder: nil)
            .padding()
    }
}

/*
private struct PreviewFolderRowView: View {
    @Query(sort: \.creationDate, order: .forward)
    private var folders: [Folder]
    var body: some View {
        FolderRow(folder: folders[0], selectedFolder: nil)
    }
}

struct FolderRow_Previews: PreviewProvider {
    static var previews: some View {
        PreviewFolderRowView()
            .padding()
        
            .modelContainer(PreviewSampleData.container)
           
       // FolderRow(folder: Folder.exampleWithSnippets(), selectedFolder: nil)
    }
}
*/
