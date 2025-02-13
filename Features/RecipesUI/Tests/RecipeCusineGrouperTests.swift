//
//  RecipeCusineGrouperTests.swift
//  RecipesUITests
//
//  Created by Dalton Hinterscher on 2/13/25.
//

import Testing
@testable import RecipesUI

struct RecipeCusineGrouperTests {
    
    private let cusineGrouper: RecipeCusineGrouper
    
    init() {
        self.cusineGrouper = RecipeCusineGrouper()
    }

    @Test("Test that items are put into the correct groups")
    func itemsPutIntoCorrectGroups() async throws {
        
        let groups = cusineGrouper.group(recipes: .mock)
        
        // There are twelve different cusines in the mock data
        #expect(groups.count == 12)
        
        // Ensure that each recipe item got put into a group
        #expect(groups.reduce(0) { $0 + $1.recipes.count } == [RecipeItem].mock.count)
        
        // Ensure that each group has the correct number of recipes
        #expect(groups.first { $0.name == "American" }?.recipes.count == 14)
        #expect(groups.first { $0.name == "British" }?.recipes.count == 27)
        #expect(groups.first { $0.name == "Canadian" }?.recipes.count == 5)
        #expect(groups.first { $0.name == "Croatian" }?.recipes.count == 1)
        #expect(groups.first { $0.name == "French" }?.recipes.count == 6)
        #expect(groups.first { $0.name == "Greek" }?.recipes.count == 1)
        #expect(groups.first { $0.name == "Italian" }?.recipes.count == 1)
        #expect(groups.first { $0.name == "Malaysian" }?.recipes.count == 2)
        #expect(groups.first { $0.name == "Polish" }?.recipes.count == 2)
        #expect(groups.first { $0.name == "Portuguese" }?.recipes.count == 1)
        #expect(groups.first { $0.name == "Russian" }?.recipes.count == 1)
        #expect(groups.first { $0.name == "Tunisian" }?.recipes.count == 2)
    }

}
