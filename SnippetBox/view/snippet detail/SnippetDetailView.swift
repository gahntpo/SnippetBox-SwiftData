//
//  SnippetDetailView.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI
import CodeEditor

struct SnippetDetailView: View {
    
    @Environment(\.modelContext) private var context
    @Bindable var snippet: Snippet
    
    @State private var isNotesAreaShown: Bool = false
    @State private var isTagEditorShown = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Title:")
                    .underline()
                
                TextField("title", text: $snippet.title)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                 
                Picker("Language", selection: $snippet.language) {
                    ForEach(CodeEditor.availableLanguages) { language in
                        Text("\(language.rawValue.capitalized)")
                            .tag(language)
                    }
                }
                .fixedSize()
                
                Spacer()
                
                Toggle(snippet.isFavorite ? "favorite" : "not", isOn: $snippet.isFavorite)
                    .toggleStyle(FavoriteToggleStyle(iconName: "star.fill"))
            }
            
            ZStack(alignment: .topTrailing) {
                CodeEditor(source: $snippet.code,
                           language: snippet.language,
                           theme: .pojoaque)
                .shadow(radius: 5)
                
                Button {
                    UIPasteboard.general.copyText(snippet.code)
                } label: {
                    Label("Copy", systemImage: "square.on.square")
                }
                .disabled(snippet.code.isEmpty)
                .labelStyle(.iconOnly)
                .padding(5)
            }
           
            .padding(.bottom)

            
            HStack {
                Text("Your Tags:")
                    .underline()
                ForEach(snippet.tags) { tag in
                    HStack {
                        Image(systemName: "tag.fill")
                            .foregroundColor(tag.color)
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
                
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text("Notes:")
                    .underline()
                Spacer()
                Button(isNotesAreaShown ? "Hide Notes" : "Show Notes") {
                    isNotesAreaShown.toggle()
                }
            }
            
            if isNotesAreaShown {
                TextEditor(text: $snippet.notes)
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .frame(maxHeight: 100)
                    .border(Color.gray)
            }
            
            
            SnippetImageView(snippet: snippet)
           
        }
        .padding()
        .toolbar {
            ToolbarItemGroup {
                ImageSelectorButton(snippet: snippet)
                
                Button {
                    isTagEditorShown.toggle()
                } label: {
                    Image(systemName: "tag")
                }
                .popover(isPresented: $isTagEditorShown) {
                    AddTagToSnippetsView(snippet: snippet)
                }
                
                Button(role: .destructive) {
                    Snippet.delete(snippet)
                    
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .foregroundColor(.pink)

            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//    MainActor.assumeIsolated { }

#Preview {
    ModelPreview { snippet in
        NavigationStack {
            SnippetDetailView(snippet: snippet)
        }
    }
}

/*
struct SnippetDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            SnippetDetailView(snippet: .constant(Snippet.preview))
        }
        .modelContainer(previewContainer)
    }
}

*/
