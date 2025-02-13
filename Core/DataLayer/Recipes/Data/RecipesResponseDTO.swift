//
//  RecipesResponseDTO.swift
//  ImageLoader
//
//  Created by Dalton Hinterscher on 2/13/25.
//

struct RecipesResponseDTO: Decodable {
    let recipes: [RecipeDTO]
    
    private enum CodingKeys: String, CodingKey {
        case recipes
    }
}
