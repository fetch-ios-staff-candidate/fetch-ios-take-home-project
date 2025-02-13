//
//  SearchBar.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import SwiftUI

public struct SearchBar: View {
    
    @Binding public var searchText: String
    @FocusState var searchFieldHasFocus: Bool

    private let backgroundColor: Color
    private let prompt: () -> Text

    public init(
        searchText: Binding<String>,
        backgroundColor: Color,
        prompt: @autoclosure @escaping () -> Text = Text("Search")
    ) {
        _searchText = searchText
        self.backgroundColor = backgroundColor
        self.prompt = prompt
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 0) {
                Image(.searchIcon)
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.fetchOrange)
                    .allowsHitTesting(false)

                TextField(
                    text: $searchText,
                    prompt: prompt().foregroundColor(.secondaryText).font(.weGoRegular(16))
                ) {}
                .frame(height: 40)
                .padding(.leading, 10)
                .padding(.trailing, 16)
                .tint(.fetchLightPurple)
                .foregroundColor(.fetchLightPurple)
                .font(.weGoRegular(16))
                .focused($searchFieldHasFocus)
                
                if searchFieldHasFocus && !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }, label: {
                        Image(systemName: "multiply.circle.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.fetchOrange)
                    })
                }
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .background(Capsule().fill(.white))
            .background(Capsule().stroke(.fetchDarkPurple.opacity(0.5), lineWidth: 1))
        }
        .padding(.vertical, 16)
        .background(backgroundColor)
    }
}

#Preview {
    SearchBar(
        searchText: .constant(""),
        backgroundColor: .fetchPrimaryBackground
    )
}

