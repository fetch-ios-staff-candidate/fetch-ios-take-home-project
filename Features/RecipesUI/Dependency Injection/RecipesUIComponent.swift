//
//  RecipesUIComponent.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import DataLayer

public protocol RecipesUIComponent {
    
    // MARK: - DataLayer Dependencies
    var recipesRepository: RecipesRepository { get }
}

extension RecipesUIComponent {
    
    var recipesUseCases: RecipesUseCasesInterface {
        RecipesUseCases(recipesRepository: recipesRepository)
    }
    
    var recipeCusineGrouper: RecipeCusineGrouper {
        .init()
    }
    
    func recipiesScreenViewModel() -> RecipesScreenViewModel {
        .init(
            recipesUseCases: recipesUseCases,
            cusineGrouper: recipeCusineGrouper
        )
    }
}

public extension RecipesUIComponent {
    func recipesScreen() -> RecipesScreen {
        .init(viewModel: recipiesScreenViewModel())
    }
    
}
