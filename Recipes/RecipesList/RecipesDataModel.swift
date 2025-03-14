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

actor RecipesDataModel: RecipesDataModelable {
    private let apiClient: APIClientable
    init(apiClient: APIClientable) {
        self.apiClient = apiClient
    }
    
    func fetchRecipes(routable: any Routable) async throws -> [Recipe] {
        let response: RecipesResponse = try await apiClient.execute(routable: routable)
        return response.recipes
    }
}
