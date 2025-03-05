//
//  ContentView.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import SwiftUI

struct ContentView<ViewModel: RecipesViewModelable>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(viewModel.recipes) { recipe in
                    Text(recipe.name)
                        .foregroundStyle(Color.black)
                }
            }
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
}

#Preview {
    ContentView(
        viewModel: RecipesViewModel(
            dataModel: RecipesDataModel(
                apiClient: APIClient()
            )
        )
    )
}
