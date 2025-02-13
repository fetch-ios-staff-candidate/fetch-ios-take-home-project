//
//  RecipeItem.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

struct RecipeItem: Identifiable, Hashable {
    let id: String
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
}
