//
//  DataLayerComponent.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

public protocol DataLayerComponent {}

extension DataLayerComponent {
    
    var apiClient: ApiClient {
        .init(baseUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/", jsonDecoder: .init())
    }
    
    var recipesWebService: RecipesWebService {
        .init(api: apiClient)
    }
}

public extension DataLayerComponent {
    
    var recipesRepository: RecipesRepository {
        .init(webService: recipesWebService)
    }
}
