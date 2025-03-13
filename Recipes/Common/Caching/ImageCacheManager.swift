//
//  ImageCacheManager.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/5/25.
//

import Foundation
import UIKit

final class ImageCacheManager {
    private let cache = URLCache.shared

    func loadImage(from url: URL) async -> UIImage? {
        let request = URLRequest(url: url)
        
        // Check if the image is already cached
        if let cachedResponse = cache.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }
        
        do {
            // Fetch the image from the network
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.isSuccess,
                  let image = UIImage(data: data) else {
                return nil
            }
            
            // Cache the image
            let cachedResponse = CachedURLResponse(response: response, data: data)
            cache.storeCachedResponse(cachedResponse, for: request)
            
            return image
        } catch {
            print("Failed to load image: \(error)")
            return nil
        }
    }
}
