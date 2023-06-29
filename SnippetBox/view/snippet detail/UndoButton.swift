//
//  UndoButton.swift
//  SnippetBox
//
//  Created by Karin Prater on 28.06.23.
//

import SwiftUI

struct UndoButton: View {
    @Environment(\.modelContext) private var context
    var body: some View {
        Button(action: {
            context.undoManager?.undo()
        }, label: {
            Text("Undo")
        })
    }
}

#Preview {
    UndoButton()
}
