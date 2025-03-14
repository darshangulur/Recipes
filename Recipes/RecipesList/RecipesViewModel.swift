//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

protocol RecipesViewModelable: AnyObject {
    var isLoading: Bool { get }
    var recipes: [Recipe] { get }
    var selectedCuisine: String { get }
    var error: String? { get }
    var cuisines: Set<String> { get }
    var isAllFilterSelected: Bool { get }
    
    func fetchRecipes() async
    func didSelectAllFilter()
    func didSelectCuisineFilter(cuisine: String)
}

@Observable
final class RecipesViewModel: RecipesViewModelable {
    enum Constants {
        static let allCuisine = "All"
        static let genericError = "Unable to load Recipes. Please try again later."
        static let emptyRecipesError = "No recipes are available."
    }
    
    // MARK: Published vars
    private var allRecipes = [Recipe]()
    private(set) var isLoading: Bool = false
    private(set) var recipes = [Recipe]()
    private(set) var selectedCuisine: String = Constants.allCuisine
    private(set) var error: String?
    private(set) var cuisines = Set<String>()
    
    // MARK: Private vars
    private let dataModel: RecipesDataModelable
    
    // MARK: Initializer
    init(dataModel: RecipesDataModelable) {
        self.dataModel = dataModel
    }
    
    func fetchRecipes() async {
        await fetchRecipes(routable: RecipeRoutable.getRecipes)
    }
    
    // Added this just to provide flexibility for Unit Testing layers to inject `Routable`
    func fetchRecipes(routable: any Routable) async {
        isLoading = true
        error = nil
        
        do {
            let recipes = try await dataModel.fetchRecipes(routable: routable)
            
            // switch to main thread before updating UI
            await MainActor.run { [weak self, recipes] in
                guard let self else {
                    return
                }
                
                self.allRecipes = recipes
                recipes.forEach {
                    self.cuisines.insert($0.cuisine)
                }
                
                loadRecipes(forCuisine: self.selectedCuisine)
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.error = Constants.genericError
                self.isLoading = false
            }
        }
    }
    
    var isAllFilterSelected: Bool {
        selectedCuisine == Constants.allCuisine
    }
    
    func didSelectAllFilter() {
        didSelectCuisineFilter(cuisine: Constants.allCuisine)
    }
    
    func didSelectCuisineFilter(cuisine: String) {
        selectedCuisine = cuisine
        loadRecipes(forCuisine: cuisine)
    }
}

// MARK: Private Helpers
private extension RecipesViewModel {
    func loadRecipes(forCuisine cuisine: String) {
        if self.selectedCuisine == Constants.allCuisine {
            self.recipes = self.allRecipes
        } else {
            // filter recipes to show only the selected cuisine
            let filteredRecipes = allRecipes.filter { recipe in
                recipe.cuisine == cuisine
            }
            self.recipes = filteredRecipes
        }
        
        if self.recipes.isEmpty {
            self.error = Constants.emptyRecipesError
        }
    }
}
