//
//  SnippetBoxApp.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import SwiftData

@main
struct SnippetBoxApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem { Label("main", systemImage: "circle") }
                
                PropertPredicateSnippetListExample()
                    .tabItem { Label("query properties", systemImage: "camera.filters") }
                
                RelationshipPredicateSnippetListExample()
                    .tabItem { Label("query relationship", systemImage: "line.3.horizontal.decrease.circle") }
            }
            .modelContainer(for: Snippet.self, isUndoEnabled: true)
        }
    }
}




