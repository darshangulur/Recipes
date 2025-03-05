//
//  RecipeRoutable.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//


enum RecipeRoutable: Routable {
    case getRecipes
    
    var urlString: String {
        switch self {
        case .getRecipes:
            "\(AppConfig.shared.CDN_URL)/recipes.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecipes:
            .GET
        }
    }
}