//
//  APIClientTests.swift
//  RecipesTests
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Testing
@testable import Recipes

struct APIClientTests {
    private let apiClient: APIClientable = APIClient()
    
    @Test("Fetch Data Success", .tags(.liveData))
    func fetchDataSuccess() async throws {
        let routable: Routable = RecipeRoutable.getRecipes
        let recipesResponse: RecipesResponse? = try? await apiClient.execute(routable: routable)
        let recipes = recipesResponse?.recipes
        
        #expect(recipes?.isEmpty == false)
        #expect(recipes?.count == 63)
        
        let malaysianRecipes = recipes?.filter { $0.cuisine == "Malaysian" }
        #expect(malaysianRecipes?.count == 2)
    }
    
    @Test(
        "Fetch Data Failure",
        .tags(.liveData),
        arguments: [
            ErrorRoutable.badURL,
            ErrorRoutable.badRequest,
            ErrorRoutable.malformedData
        ]
    )
    func fetchDataFailure(routable: ErrorRoutable) async throws {
        let responses: [ErrorRoutable: APIError] = [
            .badURL: .badURL,
            .badRequest: .request,
            .malformedData: .parsing
        ]
        
        do {
            let _: RecipesResponse? = try await apiClient.execute(routable: routable)
        } catch {
            #expect((error as? APIError) == responses[routable])
        }
    }
}
