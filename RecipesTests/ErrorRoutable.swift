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
    case httpError
    case malformedData
    case recipesOptionalDataRemoved
    case empty
    
    var urlString: String {
        switch self {
        case .badURL:
            ""
            
        case .badRequest:
            "dhhwjhdwdhk.dhdwkdjkj"
            
        case .httpError:
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json/c/123"
            
        case .malformedData:
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
            
        case .recipesOptionalDataRemoved:
            "RecipesOptionalDataRemoved"
            
        case .empty:
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        }
    }
    
    var httpMethod: Recipes.HTTPMethod {
        .GET
    }
}
