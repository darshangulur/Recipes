//
//  ImageCacheManager.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/5/25.
//

import Foundation
import UIKit

final class ImageCacheManager {
    private let cache = NSCache<NSString, UIImage>()

    func loadImage(from url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        
        if
            // Check if the image is already cached
            let image = cache.object(
                forKey: url.absoluteString.nsString
            )
        {
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
        cache.setObject(image, forKey: url.absoluteString.nsString)
        return image
    }
}
