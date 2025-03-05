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
    
    func fetchRecipes()
}

final class RecipesViewModel: RecipesViewModelable {
    enum Constants {
        static var allCuisine = "All"
    }
    
    // MARK: Published vars
    @Published private(set) var recipes = [Recipe]()
    @Published private(set) var selectedCuisine: String = Constants.allCuisine
    @Published private(set) var error: String?
    
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
                
                DispatchQueue.main.async { [weak self, recipes] in // switch to main thread before updating UI
                    guard let self else {
                        return
                    }
                    
                    if self.selectedCuisine == Constants.allCuisine {
                        self.recipes = recipes // show all recipes
                    } else {
                        // filter recipes to show only the selected cuisine
                        let filteredRecipes = recipes.filter { recipe in
                            recipe.cuisine == self.selectedCuisine
                        }
                        self.recipes = filteredRecipes
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = "Unable to load data. Please try again later."
                }
            }
        }
    }
}
