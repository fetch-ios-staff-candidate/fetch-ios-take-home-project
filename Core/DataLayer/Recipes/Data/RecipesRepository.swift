//
//  RecipesRepository.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

public class RecipesRepository {

    // MARK: - Variables
    
    private let webService: RecipesWebService
    
    // MARK: - Initializers
    
    init(webService: RecipesWebService) {
        self.webService = webService
    }
    
    // MARK: - Public Interface
    
    public func fetchAll() async throws -> [Recipe] {
        let recipeDTOs = try await webService.fetchAll()
        
        // If we wanted to have a persisent data store, such as using CoreData/SwiftData, we would save the recipes here.
        // For simplicity and since the requirements did not ask to cache the recipes, we will just return the recipes that
        // we receive from the web request each time.
        //
        // await recipiesDao.process(dtos: recipeDTOs)
        
        return recipeDTOs.map {
            Recipe(
                uuid: $0.id,
                cuisine: $0.cuisine,
                name: $0.name,
                photoUrlLarge: $0.photoUrlLarge,
                photoUrlSmall: $0.photoUrlSmall,
                sourceUrl: $0.sourceUrl,
                youtubeUrl: $0.youtubeUrl
            )
        }
    }
}
