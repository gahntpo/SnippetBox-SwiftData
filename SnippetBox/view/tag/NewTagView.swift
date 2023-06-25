//
//  NewTagView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI

struct NewTagView: View {
    
    let snippet: Snippet
    let searchTerm: String
    
    let colorOptions = [Color(red: 0, green: 0, blue: 0),
                        Color(red: 1, green: 0, blue: 0),
                        Color(red: 1, green: 0, blue: 1),
                        Color(red: 1, green: 1, blue: 0),
                        Color(red: 0, green: 0, blue: 1),
                        Color(red: 0, green: 1, blue: 0)]
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedColor = Color(red: 0, green: 0, blue: 0)
    
    var body: some View {
        
        VStack {
            
            HStack {
                ForEach(colorOptions) { color in
                    Circle().fill(color)
                        .frame(width: selectedColor == color ? 20 : 15)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            
            Button {
                let tag = Tag(name: searchTerm)
                tag.color = selectedColor
                snippet.tags.append(tag)
                
                dismiss()
            } label: {
                Text("Create as new Tag")
            }
            .disabled(searchTerm.count == 0)
        }
    }
}

extension Color: Identifiable {
    public var id: String {
        var id = ""
        guard let components = self.cgColor?.components else {
            return id
        }
        for component in components {
            id.append(" \(component)")
        }
        return id
    }
}

struct NewTagView_Previews: PreviewProvider {
    static var previews: some View {
        NewTagView(snippet: Snippet.example(),
                   searchTerm: "test")
    }
}
