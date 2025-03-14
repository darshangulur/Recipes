//
//  RecipesDataModelTests.swift
//  RecipesTests
//
//  Created by Darshan Gulur Srinivasa on 3/13/25.
//

import Testing
@testable import Recipes

struct RecipesDataModelTests {
    @Test("Fetch recipes Success", .tags(.liveData))
    func fetchRecipesSuccess() async throws {
        let recipes: [Recipe]? = try? await fetchRecipes(
            apiClient: APIClient(),
            routable: RecipeRoutable.getRecipes
        )
        
        #expect(recipes?.isEmpty == false)
    }
    
    @Test(
        "Fetch Recipes Failure",
        .tags(.liveData),
        arguments: [ErrorRoutable.badURL]
    )
    func fetchRecipesFailure(routable: ErrorRoutable) async throws {
        let responses: [ErrorRoutable: APIError] = [.badURL: .badURL]
        
        do {
            let _: [Recipe]? = try await fetchRecipes(
                apiClient: MockAPIClient(),
                routable: routable
            )
        } catch {
            #expect((error as? APIError) == responses[routable])
        }
    }
}

// MARK: Helpers
private extension RecipesDataModelTests {
    private func fetchRecipes(apiClient: any APIClientable, routable: any Routable) async throws -> [Recipe] {
        let dataModel: any RecipesDataModelable = RecipesDataModel(apiClient: apiClient)
        return try await dataModel.fetchRecipes(routable: routable)
    }
}
