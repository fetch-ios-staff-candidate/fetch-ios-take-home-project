//
//  MockRecipeItem.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import DataLayer
import Foundation

extension RecipeItem {
    
    static var mock: RecipeItem {
        [RecipeItem].mock.randomElement()!
    }
    
}

extension Collection where Element == RecipeItem {
    
    static var mock: [RecipeItem] {
        let jsonDecoder = JSONDecoder()

        guard let url = Bundle.recipesUI.path(forResource: "mock_recipes", ofType: "json"),
              let data = try? NSData(contentsOfFile: url) as Data,
              let mockObjects = try? jsonDecoder.decode([[String: String]].self, from: data) else { return [] }
        
        return mockObjects.map {
            RecipeItem(
                id: $0["uuid"] ?? "",
                cuisine: $0["cuisine"] ?? "",
                name: $0["name"] ?? "",
                photoUrlLarge: $0["photo_url_large"] ?? "",
                photoUrlSmall: $0["photo_url_small"] ?? "",
                sourceUrl: $0["source_url"] ?? "",
                youtubeUrl: $0["youtube_url"] ?? ""
            )
        }
        
    }
}
