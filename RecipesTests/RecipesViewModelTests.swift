//
//  RecipesViewModelTests.swift
//  RecipesTests
//
//  Created by Darshan Gulur Srinivasa on 3/13/25.
//

import Testing
@testable import Recipes

struct RecipesViewModelTests {
    @Test("Fetch Recipes Success")
    func fetchRecipesSuccess() async throws {
        let viewModel: any RecipesViewModelable = RecipesViewModel(
            dataModel: RecipesDataModel(
                apiClient: APIClient()
            )
        )
        await viewModel.fetchRecipes()
        #expect(viewModel.recipes.count == 63)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.selectedCuisine == RecipesViewModel.Constants.allCuisine)
        #expect(viewModel.error == nil)
        #expect(viewModel.cuisines.count == 12)
        #expect(viewModel.isAllFilterSelected)
        
        let americanCuisine = "American"
        viewModel.didSelectCuisineFilter(cuisine: americanCuisine)
        #expect(viewModel.selectedCuisine == americanCuisine)
        #expect(viewModel.recipes.count == 14)
        #expect(viewModel.isAllFilterSelected == false)
        
        viewModel.didSelectAllFilter()
        #expect(viewModel.selectedCuisine == RecipesViewModel.Constants.allCuisine)
        #expect(viewModel.isAllFilterSelected)
    }
    
    @Test("Fetch Recipes Error")
    func fetchRecipesError() async throws {
        let viewModel: any RecipesViewModelable = RecipesViewModel(
            dataModel: RecipesDataModel(
                apiClient: MockAPIClient()
            )
        )
        await viewModel.fetchRecipes()
        #expect(viewModel.recipes.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.error?.isEmpty == false)
    }
}
