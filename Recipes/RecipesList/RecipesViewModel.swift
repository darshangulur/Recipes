//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

protocol RecipesViewModelable: ObservableObject {
    var recipes: [Recipe] { get }
    var selectedCuisine: String { get }
    var error: String? { get }
    var cuisines: Set<String> { get }
    var isAllFilterSelected: Bool { get }
    
    func fetchRecipes()
    func didSelectAllFilter()
    func didSelectCuisineFilter(cuisine: String)
}

final class RecipesViewModel: RecipesViewModelable {
    enum Constants {
        static var allCuisine = "All"
    }
    
    // MARK: Published vars
    private var allRecipes = [Recipe]()
    @Published private(set) var recipes = [Recipe]()
    @Published private(set) var selectedCuisine: String = Constants.allCuisine
    @Published private(set) var error: String?
    @Published private(set) var cuisines = Set<String>()
    
    // MARK: Private vars
    private let dataModel: RecipesDataModelable
    
    // MARK: Initializer
    init(dataModel: RecipesDataModelable) {
        self.dataModel = dataModel
    }
    
    func fetchRecipes() {
        Task {
            do {
                let recipes = try await dataModel.fetchRecipes()
                
                // switch to main thread before updating UI
                DispatchQueue.main.async { [weak self, recipes] in
                    guard let self else {
                        return
                    }
                    
                    self.allRecipes = recipes
                    recipes.forEach {
                        self.cuisines.insert($0.cuisine)
                    }
                    
                    loadRecipes(forCuisine: self.selectedCuisine)
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = "Unable to load data. Please try again later."
                }
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
    }
}
