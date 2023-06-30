//
//  TagCell.swift
//  SnippetBox
//
//  Created by Karin Prater on 30.06.23.
//

import SwiftUI

struct TagCell: View {
    let tag: Tag
    var body: some View {
        HStack {
            Image(systemName: "tag.fill")
                .foregroundColor(tag.color)
                .shadow(color: Color(white: 0.8), radius: 2, x: 1, y: 0)
                
            Text(tag.name)
        }
        .padding(5)
        
        .background(
            ZStack {
                Capsule().fill(Color.white)
                Capsule().stroke(tag.color)
            }
        )
    }
}

#Preview {
    ModelPreview { tag in
        TagCell(tag: tag)
    }
   
}
