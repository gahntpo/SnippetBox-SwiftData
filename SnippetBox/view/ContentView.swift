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
            if selectedSnippet != nil {
                SnippetDetailView(snippet: $selectedSnippet)
            } else {
                Text("Placeholder")
            }
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        ContentView()
            .modelContainer(PreviewSampleData.container)
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(PreviewSampleData.container)
    }
}
*/
