//
//  CachedAsyncImage.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/5/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    @State private var image: UIImage?
    private let cacheManager = ImageCacheManager()
    
    let url: URL
    init(url: URL, imageDimension: CGFloat = Constants.imageDimension) {
        self.url = url
    }

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .frame(
                    width: Constants.imageDimension,
                    height: Constants.imageDimension
                )
                .clipShape(.rect(cornerRadius: Constants.imageCornerRadius))
        } else {
            ProgressView()
                .task {
                    do {
                        image = try await cacheManager.loadImage(from: url)
                    } catch {
                        image = UIImage(named: Constants.placeholderImageName)
                    }
                }
        }
    }
    
    enum Constants {
        static let imageDimension: CGFloat = 100
        static let imageCornerRadius: CGFloat = 8.0
        static let placeholderImageName: String = "photo.fill"
    }
}
