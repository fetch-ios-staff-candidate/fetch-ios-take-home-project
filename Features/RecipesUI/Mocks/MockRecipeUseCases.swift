//
//  MockRecipeUseCases.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import Foundation

class MockRecipeUseCases: RecipesUseCasesInterface {
    
    private let secondsDelay: Int
    private let items: [RecipeItem]
    private let throwError: Bool
    
    init(secondsDelay: Int, items: [RecipeItem], throwError: Bool = false) {
        self.secondsDelay = secondsDelay
        self.items = items
        self.throwError = throwError
    }

    func fetchAll() async throws -> [RecipeItem] {
        
        if throwError {
            throw NSError(domain: "MockRecipeUseCases", code: 0, userInfo: [:])
        }
        
        try await Task.sleep(nanoseconds: UInt64(1_000_000_000 * secondsDelay))
        return items
    }
}

extension RecipesUseCasesInterface where Self == MockRecipeUseCases {
    
    static func mock(
        secondsDelay: Int,
        items: [RecipeItem],
        throwError: Bool = false
    ) -> MockRecipeUseCases {
        .init(secondsDelay: secondsDelay, items: items, throwError: throwError)
    }
}
