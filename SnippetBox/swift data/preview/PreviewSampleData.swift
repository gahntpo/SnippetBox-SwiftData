/*


Abstract:
The preview sample data actor which provides an in-memory model container.
*/

import SwiftData
import SwiftUI

/**
 Preview sample data. from demo project Backyard Birds
 */
actor PreviewSampleData {
    @MainActor
    static var container: ModelContainer = {
        let schema = Schema([Folder.self, Snippet.self, Tag.self])
        let configuration = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = [
            Snippet.example2(), Folder.exampleWithSnippets()
        ]
        sampleData.forEach {
            container.mainContext.insert($0)
        }
        return container
    }()
    
    
    @MainActor
    static var emptyTestContext: ModelContext = {
        let schema = Schema([Folder.self, Snippet.self, Tag.self])
        let configuration = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        return container.mainContext
    }()
}

// add all data here that you want to use with the previews:
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Snippet.self,
                                           ModelConfiguration(inMemory: true))
        
        Task { @MainActor in
            
            let context = container.mainContext
            
            let snip = Snippet.example2()
            
            context.insert(snip)
            context.insert(Snippet.example3())
            context.insert(Snippet.example4())
            
            context.insert(Folder.exampleWithSnippets())
            
            let tag = Tag.example()
            tag.snippets.append(snip)
            
            
            context.insert(Tag.example2())
            context.insert(Tag.example3())
        }
        
        return container
    } catch {
        fatalError("Failed to create container: \(error.localizedDescription)")
    }
}()
