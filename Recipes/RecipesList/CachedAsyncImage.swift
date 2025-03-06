//
//  CachedAsyncImage.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/5/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL
    @State private var image: UIImage?
    private let constants = Constants()

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .frame(
                    width: constants.imageDimension,
                    height: constants.imageDimension
                )
                .clipShape(.rect(cornerRadius: constants.imageCornerRadius))
        } else {
            ProgressView()
                .task {
                    image = await ImageCacheManager.shared.loadImage(from: url) ?? UIImage(named: constants.placeholderImageName)
                }
        }
    }
    
    struct Constants {
        let imageDimension: CGFloat = 100
        let imageCornerRadius: CGFloat = 8.0
        let placeholderImageName: String = "photo.fill"
    }
}
