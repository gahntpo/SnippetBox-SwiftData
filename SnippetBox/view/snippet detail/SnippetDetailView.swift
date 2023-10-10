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
                Picker("Language", selection: $snippet.codingLanguageData) {
                    ForEach(CodingLanguage.allCases) { language in
                        Text("\(language.title)")
                            .tag(language)
                    }
                }
                
                Spacer()
                
                Toggle(snippet.isFavorite ? "favorite" : "not", isOn: $snippet.isFavorite)
                    .toggleStyle(FavoriteToggleStyle(iconName: "star.fill"))
            }
            
            ZStack(alignment: .topTrailing) {
                CodeEditor(source: $snippet.code,
                           language: .swift,
                           theme: .pojoaque)
              
                Button {
                    UIPasteboard.general.copyText(snippet.code)
                } label: {
                    Label("Copy", systemImage: "square.on.square")
                }
                .disabled(snippet.code.isEmpty)
                .labelStyle(.iconOnly)
                .padding(5)
            }
            .shadow(radius: 5)
            .padding(.bottom)

            
           HStack(alignment: .firstTextBaseline) {
                Text("Tags:")
                    .underline()
                
                FlowLayout(alignment: .leading) {
                    
                    ForEach(snippet.tags) { tag in
                        TagCell(tag: tag)
                            .contextMenu {
                                Button(role: .destructive) {
                                    if let index = snippet.tags.firstIndex(where: { $0.uuid == tag.uuid }) {
                                        snippet.tags.remove(at: index)
                                    }
                                } label: {
                                    Text("Remove from snippet")
                                }

                            }
                    }
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
            
           ImageSelectorButton(snippet: snippet)
                .padding(.top)
            SnippetImageView(snippet: snippet)
              
           
        }
        .padding()
        .toolbar {
            ToolbarItemGroup {
               // ImageSelectorButton(snippet: snippet)
               // does not work here
                
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
