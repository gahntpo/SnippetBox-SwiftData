//
//  FolderRow.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI

struct FolderRow: View {
    @ObservedObject var folder: Folder
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
            Spacer()
            
#else
            Image(systemName: "folder")
               // .foregroundColor(folderColor)
                //.foregroundStyle(folderColor)
            TextField("name", text: $folder.name)
                .focused($textFieldIsSelected)
#endif
            Spacer()
            Text("\(folder.snippets.count)")
                .foregroundColor(.secondary)
        }
        
        .contextMenu {
            
            Button("Rename") {
                startRenameAction()
            }
            Button("Delete") {
                Folder.delete(folder)
            }
        }

    }
    
    func startRenameAction() {
        #if os(OSX)
        textFieldIsSelected = true
        #else
        showRenameEditor = true
        #endif
    }
}

struct FolderRow_Previews: PreviewProvider {
    static var previews: some View {
        FolderRow(folder: Folder.exampleWithSnippets(context: PersistenceController.preview.container.viewContext), selectedFolder: nil)
    }
}
