//
//  ContentView.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import SwiftUI

struct ContentView<ViewModel: RecipesViewModelable>: View {
    private let constants = Constants()
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                filterView
                
                listView
            }
            .navigationTitle(Text("Recipes"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
    
    @ViewBuilder
    var filterView: some View {
        let rows = (0...1) // 2 rows
            .map { _ in
                GridItem(
                    .adaptive(
                        minimum: constants.filterGridMinimum,
                        maximum: constants.filterGridMaximum
                    )
                )
            }
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: constants.filterInterSpacing) {
                ForEach(viewModel.cuisines.sorted(), id: \.self) { cuisine in
                    Button(action: {
                        guard cuisine != viewModel.selectedCuisine else {
                            return
                        }
                        
                        viewModel.didSelectCuisineFilter(
                            cuisine: cuisine
                        )
                    }) {
                        Text(cuisine)
                            .padding(.all, constants.filterContentPadding)
                            .background(
                                filterBackgroundColor(forCuisine: cuisine)
                            )
                            .foregroundColor(
                                filterForegroundColor(forCuisine: cuisine)
                            )
                            .fontWeight(
                                filterFontWeight(forCuisine: cuisine)
                            )
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: CGFloat(rows.count) * constants.filterSectionHeight)
    }
    
    var listView: some View {
        ScrollView(showsIndicators: false) {
            if viewModel.recipes.isEmpty {
                Text(
                    "Unable to load recipes.\nPull down to refresh or please check back later."
                )
                .multilineTextAlignment(.center)
                .padding(.top, constants.errorTopPadding)
            } else {
                    LazyVStack(alignment: .leading) { // creates rows only as needed
                        ForEach(viewModel.recipes) { recipe in
                            VStack(alignment: .leading) {
                                HStack(alignment: .top, spacing: constants.sectionPadding) {
                                    thumbnail(forRecipe: recipe)
                                    
                                    textContent(recipe: recipe)
                                }
                                .padding()
                                
                                divider
                            }
                        }
                    }
            }
        }
        .refreshable {
            viewModel.fetchRecipes()
        }
    }
    
    @ViewBuilder
    func thumbnail(forRecipe recipe: Recipe) -> some View {
        if let url = recipe.photoURLSmall {
            CachedAsyncImage(url: url)
        }
    }
    
    func textContent(recipe: Recipe) -> some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.title3)
            
            Text(recipe.cuisine)
                .font(.body)
                .foregroundStyle(Color.gray)
        }
    }
    
    var divider: some View {
        Divider()
            .frame(height: constants.dividerHeight)
            .background(constants.dividerColor)
            .padding(.leading)
    }
    
    func filterBackgroundColor(forCuisine cuisine: String) -> Color {
        viewModel.selectedCuisine == cuisine
        ? Color.blue
        : Color.blue.opacity(constants.filterBackgroundOpacity)
    }
    
    func filterForegroundColor(forCuisine cuisine: String) -> Color {
        viewModel.selectedCuisine == cuisine ? .white : .blue
    }
    
    func filterFontWeight(forCuisine cuisine: String) -> Font.Weight {
        viewModel.selectedCuisine == cuisine ? .bold : .regular
    }
    
    struct Constants {
        let imageDimension: CGFloat = 100
        let imageCornerRadius: CGFloat = 8.0
        let placeholderImageName = "photo.fill"
        
        let dividerColor = Color("DividerColor")
        let dividerHeight: CGFloat = 1.0
        
        let sectionPadding: CGFloat = 10.0
        
        let filterInterSpacing: CGFloat = 12.0
        let filterContentPadding: CGFloat = 10.0
        let filterBackgroundOpacity: CGFloat = 0.2
        let filterSectionHeight: CGFloat = 50.0
        let filterGridMinimum: CGFloat = 30.0
        let filterGridMaximum: CGFloat = 100.0
        
        let errorTopPadding: CGFloat = 100.0
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
