//
//  RecipesDataModelTests.swift
//  RecipesTests
//
//  Created by Darshan Gulur Srinivasa on 3/13/25.
//

import Testing
@testable import Recipes

struct RecipesDataModelTests {
    private let apiClient: APIClientable = APIClient()
    
    @Test("Fetch recipes Success", .tags(.liveData))
    func fetchRecipesSuccess() async throws {
        let routable: Routable = RecipeRoutable.getRecipes
        let recipesResponse: RecipesResponse? = try? await apiClient.execute(routable: routable)
        let recipes = recipesResponse?.recipes
        
        #expect(recipes?.isEmpty == false)
    }
    
    @Test(
        "Fetch Recipes Failure",
        .tags(.liveData),
        arguments: [ErrorRoutable.badURL]
    )
    private func fetchRecipesFailure(routable: ErrorRoutable) async throws {
        let responses: [ErrorRoutable: APIError] = [.badURL: .badURL]
        
        do {
            let _: RecipesResponse? = try await apiClient.execute(routable: routable)
        } catch {
            #expect((error as? APIError) == responses[routable])
        }
    }
}
