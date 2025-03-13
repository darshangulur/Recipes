//
//  ErrorRoutable.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/13/25.
//

@testable import Recipes

enum ErrorRoutable: Routable {
    case badURL
    case badRequest
    case malformedData
    case recipesOptionalDataRemoved
    
    var urlString: String {
        switch self {
        case .badURL:
            ""
            
        case .badRequest:
            "dhhwjhdwdhk.dhdwkdjkj"
            
        case .malformedData:
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
            
        case .recipesOptionalDataRemoved:
            "RecipesOptionalDataRemoved"
        }
    }
    
    var httpMethod: Recipes.HTTPMethod {
        .GET
    }
}
