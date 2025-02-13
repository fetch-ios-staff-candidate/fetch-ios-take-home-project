//
//  RecipesWebService.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

class RecipesWebService: WebService<RecipesPaths> {

    public func fetchAll() async throws -> [RecipeDTO] {
        (try await get(.all) as RecipesResponseDTO).recipes
    }
}
