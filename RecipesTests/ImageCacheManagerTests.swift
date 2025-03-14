//
//  ImageCacheManagerTests.swift
//  RecipesTests
//
//  Created by Darshan Gulur Srinivasa on 3/14/25.
//

import Foundation
import Testing
@testable import Recipes

struct ImageCacheManagerTests {
    private let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!
    private let cacheManager = ImageCacheManager()
    
    @Test("Image Cache Success")
    func imageCacheSuccess() async throws {
        let downloadedImage = try await cacheManager.loadImage(from: url)
        #expect(downloadedImage != nil)
        #expect(downloadedImage.size != .zero)
        
        // Download from cache
        _ = try await cacheManager.loadImage(from: url)
        #expect(downloadedImage != nil)
    }
    
    @Test("Image Cache Error, Bad URL")
    func imageDownloadBadURLError() async throws {
        do {
            let _ = try await cacheManager.loadImage(from: URL(string: "badURL")!)
        } catch {
            #expect((error as? APIError) == .badURL)
        }
    }
    
    @Test("Image Cache Error, HTTP Error")
    func imageDownloadError() async throws {
        do {
            let _ = try await cacheManager.loadImage(from: RecipeRoutable.getRecipes.url!)
        } catch {
            #expect((error as? APIError) == .httpError)
        }
    }
}
