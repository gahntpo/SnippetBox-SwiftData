//
//  ImageSelectorButton.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import PhotosUI

struct ImageSelectorButton: View {
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var snippet: Snippet
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        
        PhotosPicker(selection: $selectedItem,
                     matching: .images,
                     photoLibrary: .shared()) {
   
            Label("Import photo", systemImage: "photo")
      
        }
        .onChange(of: selectedItem) { newValue in
              Task {
                  do {
                      if let data = try await newValue?.loadTransferable(type: Data.self) {
                          update(data: data)
                      }
                  } catch {
                      print("Photopicker error: \(error.localizedDescription)")
                  }
              }
        }
    }
    
    @MainActor
    func update(data: Data) {
        snippet.image = data
    }
}

struct ImageSelectorButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectorButton(snippet: Snippet.example(context: PersistenceController.preview.container.viewContext))
    }
}
