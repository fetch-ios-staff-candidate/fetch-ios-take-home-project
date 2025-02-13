//
//  RecipeCusineGrouper.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

class RecipeCusineGrouper {

    func group(recipes: [RecipeItem]) -> [RecipeCusineGroup] {
        var groups = [String: RecipeCusineGroup]()
        
        recipes.forEach { recipe in
            let key = recipe.cuisine
            var group = groups[key, default: .init(name: key, recipes: [])]
            group.recipes.append(recipe)
            groups[key] = group
        }
        
        return groups.values.sorted { $0.name < $1.name }
    }
}
