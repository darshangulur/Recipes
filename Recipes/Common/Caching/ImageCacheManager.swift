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

    func loadImage(from url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        
        // Check if the image is already cached
        if let cachedResponse = cache.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw APIError.badURL
        }
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.isSuccess,
            let image = UIImage(data: data)
        else {
            throw APIError.httpError
        }
        
        // Cache the image
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)
        
        return image
    }
}
