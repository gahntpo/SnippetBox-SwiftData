/*


Abstract:
The preview sample data actor which provides an in-memory model container.
*/

import SwiftData
import SwiftUI

/**
 Preview sample data.
 */
actor PreviewSampleData {
    @MainActor
    static var container: ModelContainer = {
        let schema = Schema([Folder.self, Snippet.self, Tag.self])
        let configuration = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = [
            Snippet.example(), Folder.exampleWithSnippets()
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
            
            let snip = Snippet.example()
            
            container.mainContext.insert(object: snip)
            container.mainContext.insert(object: Folder.exampleWithSnippets())
            
           // snip.tags.append(Tag.example())
            let tag = Tag.example()
            tag.snippets.append(snip)
            
            
            container.mainContext.insert(object: Tag.example2())
            container.mainContext.insert(object: Tag.example3())
        }
        
        return container
    } catch {
        fatalError("Failed to create container: \(error.localizedDescription)")
    }
}()

