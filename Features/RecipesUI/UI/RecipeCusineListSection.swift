//
//  RecipeCusineListSection.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import ImageLoader
import SwiftUI

struct RecipeCusineListSection: View {
    
    let group: RecipeCusineGroup
    let style: RecipeCusineGroupsList.Style
    
    var body: some View {
        Section(content: {
            
            switch style {
            case .grid:
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(group.recipes) {
                            RecipeGridItemView(recipe: $0)
                        }
                    }
                    .padding([.top, .horizontal], 16)
                }
            case .simple:
                ForEach(Array(group.recipes.enumerated()), id: \.element.id) { index, recipe in
                    RecipeSimpleItemView(recipe: recipe)
                    
                    if index != group.recipes.count - 1 {
                        Divider()
                            .padding(.leading, 112)                        
                    }
                }
            }
           
        }, header: {
            Text("\(group.name) (\(group.recipes.count))")
                .textStyle(.listSectionHeader)
                .preferredColorScheme(.light)
        })
        .listRowBackground(Color.fetchPrimaryBackground)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
        .textCase(nil)
    }
}

@ViewBuilder
private func BuildPreview(style: RecipeCusineGroupsList.Style) -> some View {
    List {
        RecipeCusineListSection(group: .mock, style: style)
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .background(.fetchPrimaryBackground)
    .environmentObject(RemoteImageDownloader.mock)
}

#Preview("Grid Style") {
    BuildPreview(style: .grid)
}

#Preview("Simple Style") {
    BuildPreview(style: .simple)
}
