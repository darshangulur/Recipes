//
//  RecipesDataModel.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

protocol RecipesDataModelable {
    func fetchRecipes(routable: any Routable) async throws -> [Recipe]
}

struct RecipesDataModel: RecipesDataModelable {
    let apiClient: APIClientable
    
    func fetchRecipes(routable: any Routable) async throws -> [Recipe] {
        let response: RecipesResponse = try await apiClient.execute(routable: routable)
        return response.recipes
    }
}
