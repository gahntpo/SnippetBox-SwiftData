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
            ContentView()
                .modelContainer(for: Snippet.self)
        }
    }
}




