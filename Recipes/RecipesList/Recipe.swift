//
//  Recipe.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let uuid: String
    let cuisine: String
    let name: String
    let photoURLSmall: String
    var sourceURL: String?
    var youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    var id: String {
        uuid
    }
}
