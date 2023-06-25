//
//  FolderEditorView.swift
//  SnippetBox
//
//  Created by Karin Prater on 25.06.23.
//

import SwiftUI

struct FolderEditorView: View {
    
    @Environment(\.dismiss) var dismiss
    let folder: Folder
    
    @State private var name: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Rename folder: \(folder.name)")
                .font(.title2)
            
            TextField("Folder Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .focused($isFocused)
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                
                Button("Save Changes") {
                    folder.name = name
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onAppear {
           name = folder.name
            isFocused = true
        }
        
    }
}

#Preview {
    FolderEditorView(folder: Folder.exampleWithSnippets())
}
