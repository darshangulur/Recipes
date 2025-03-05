//
//  ContentView.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import SwiftUI

struct ContentView<ViewModel: RecipesViewModelable>: View {
    struct Constants {
        let imageDimension: CGFloat = 100
        let imageCornerRadius: CGFloat = 8.0
        let placeholderImageName = "photo.fill"
        let dividerColor = Color("DividerColor")
        let dividerHeight: CGFloat = 1.0
        let sectionPadding: CGFloat = 10.0
    }
    
    private let constants = Constants()
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) { // creates rows only as needed
                ForEach(viewModel.recipes) { recipe in
                    VStack(alignment: .leading) {
                        HStack(alignment: .top, spacing: constants.sectionPadding) {
                            recipeThumbnail(recipe: recipe)
                            
                            textContent(recipe: recipe)
                        }
                        .padding()
                        
                        divider
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
    
    func recipeThumbnail(recipe: Recipe) -> some View {
        AsyncImage(
            url: recipe.photoURLSmall,
            content: { image in
                image
                    .resizable()
                    .frame(
                        width: constants.imageDimension,
                        height: constants.imageDimension
                    )
                    .clipShape(.rect(cornerRadius: constants.imageCornerRadius))
            },
            placeholder: {
                Image(systemName: constants.placeholderImageName)
                    .resizable()
                    .frame(
                        width: constants.imageDimension,
                        height: constants.imageDimension
                    )
                    .foregroundStyle(Color.gray)
            }
        )
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
