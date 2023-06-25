//
//  SnippetImageView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI

struct SnippetImageView: View {
    var snippet: Snippet
    
    @State private var image: UIImage? = nil
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        VStack {
            
            if let data = snippet.image, let uiimage = UIImage(data: data) {
                Image(uiImage: uiimage)
                    .resizable()
                    .scaledToFit()
            }
            
        }
        .padding()
        .task {
            image = await snippet.createFullImage()
        }
    }
}

struct SnippetImageView_Previews: PreviewProvider {
    static var previews: some View {
        SnippetImageView(snippet: Snippet.example())
    }
}
