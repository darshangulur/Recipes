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
    
    @Test("Fetch Recipes Success", .tags(.liveData))
    func fetchRecipesSuccess() async throws {
        let routable: Routable = RecipeRoutable.getRecipes
        let recipesResponse: RecipesResponse? = try? await apiClient.execute(routable: routable)
        let recipes = recipesResponse?.recipes
        
        #expect(recipes?.isEmpty == false)
        #expect(recipes?.count == 63)
        
        let malaysianRecipes = recipes?.filter { $0.cuisine == "Malaysian" }
        #expect(malaysianRecipes?.count == 2)
    }
    
    @Test(
        "Fetch Recipes Failure",
        .tags(.mockData),
        arguments: [
            ErrorRoutable.badURL,
            ErrorRoutable.badRequest,
            ErrorRoutable.malformedData
        ]
    )
    private func fetchRecipesFailure(routable: ErrorRoutable) async throws {
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

private enum ErrorRoutable: Routable {
    case badURL
    case badRequest
    case malformedData
    
    var urlString: String {
        switch self {
        case .badURL:
            ""
            
        case .badRequest:
            "dhhwjhdwdhk.dhdwkdjkj"
            
        case .malformedData:
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        }
    }
    
    var httpMethod: Recipes.HTTPMethod {
        .GET
    }
}
