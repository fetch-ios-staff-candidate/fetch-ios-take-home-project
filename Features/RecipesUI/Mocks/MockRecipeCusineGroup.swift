//
//  MockRecipeCusineGroup.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

extension RecipeCusineGroup {
    
    static var mock: RecipeCusineGroup {
        [RecipeCusineGroup].mock[0]
    }
}

extension Collection where Element == RecipeCusineGroup {
    
    static var mock: [RecipeCusineGroup] {
        RecipeCusineGrouper.mock.group(recipes: .mock)
    }
}
