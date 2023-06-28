//
//  ModelPreview.swift
//  SnippetBox
//
//  Created by Karin Prater on 28.06.23.
//

/*
 for use with SwiftUI Previews
 
 #Preview {
     ModelPreview { snippet in
         NavigationStack {
             SnippetDetailView(snippet: .constant(snippet))
         }
     }
 }
 
 */


import SwiftUI
import SwiftData

public struct ModelPreview<Model: PersistentModel, Content: View>: View {
    var content: (Model) -> Content
    
    public init(@ViewBuilder content: @escaping (Model) -> Content) {
        self.content = content
    }
    
    public var body: some View {
        PreviewContentView(content: content)
            .modelContainer(previewContainer)
    }
    
    struct PreviewContentView: View {
        var content: (Model) -> Content
        
        @Query private var models: [Model]
        @State private var waitedToShowIssue = false
        
        var body: some View {
            if let model = models.first {
                content(model)
            } else {
                ContentUnavailableView {
                    Label {
                        Text(verbatim: "Could not load model for previews")
                    } icon: {
                        Image(systemName: "xmark")
                    }
                }
                .opacity(waitedToShowIssue ? 1 : 0)
                .task {
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        waitedToShowIssue = true
                    }
                }
            }
        }
    }
}
