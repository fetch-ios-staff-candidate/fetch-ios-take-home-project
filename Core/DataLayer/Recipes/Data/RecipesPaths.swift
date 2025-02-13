//
//  RecipesPaths.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

enum RecipesPaths: WebServicePath {
    case all
    
    var path: String {
        switch self {
        case .all:
            return "recipes.json"
        }
        
    }
}
