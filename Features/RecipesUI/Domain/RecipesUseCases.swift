//
//  RecipesUseCases.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import DataLayer

protocol RecipesUseCasesInterface {
    func fetchAll() async throws -> [RecipeItem]
}

class RecipesUseCases: RecipesUseCasesInterface {

    // MARK: - Variables
    
    private let recipesRepository: RecipesRepository
    
    // MARK: - Initializers
    
    init(recipesRepository: RecipesRepository) {
        self.recipesRepository = recipesRepository
    }
    
    // MARK: - RecipesUseCasesInterface
    
    func fetchAll() async throws -> [RecipeItem] {
        try await recipesRepository.fetchAll().map { $0.screenItem }
    }
}

fileprivate extension Recipe {
    var screenItem: RecipeItem {
        RecipeItem(
            id: uuid,
            cuisine: cuisine,
            name: name,
            photoUrlLarge: photoUrlLarge,
            photoUrlSmall: photoUrlSmall,
            sourceUrl: sourceUrl,
            youtubeUrl: youtubeUrl
        )
    }
}
