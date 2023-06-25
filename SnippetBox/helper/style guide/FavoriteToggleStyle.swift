//
//  FavoriteToggleStyle.swift
//  SnippetBox
//
//  Created by Karin Prater on 21.06.23.
//

import SwiftUI

struct FavoriteToggleStyle: ToggleStyle {
    let iconName: String
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Image(systemName: iconName)
                .foregroundColor(configuration.isOn ? .yellow : .gray)
                .imageScale(configuration.isOn ? .large : .medium)
        }
        .frame(width: 44, height: 44)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                configuration.isOn.toggle()
            }
        }
    }
}

struct FavoriteToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Toggle("isFavorit", isOn: .constant(false))
            Toggle("isFavorit", isOn: .constant(true))
        }
            .toggleStyle(FavoriteToggleStyle(iconName: "star.fill"))
            .padding()
    }
}
