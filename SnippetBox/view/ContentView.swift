//
//  ContentView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedFolder: Folder? = nil
    @State private var selectedSnippet: Snippet? = nil
    
    var body: some View {
        NavigationSplitView {
            FolderListView(selectedFolder: $selectedFolder)
        } content: {
            if let folder = selectedFolder {
                SnippetListView(for: folder, selectedSnippet: $selectedSnippet)
            } else {
                Text("Placeholder")
            }
                
        } detail: {
            if let snippet = selectedSnippet {
                SnippetDetailView(snippet: snippet)
            } else {
                Text("Placeholder")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(PreviewSampleData.container)
    }
}
*/
