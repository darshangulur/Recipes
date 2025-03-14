//
//  Recipe.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let uuid: String
    let cuisine: String
    let name: String
    let smallPhotoURLString: String?
    var sourceURLString: String?
    var youtubeURLString: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case smallPhotoURLString = "photo_url_small"
        case sourceURLString = "source_url"
        case youtubeURLString = "youtube_url"
    }
    
    var id: String {
        uuid
    }
}
