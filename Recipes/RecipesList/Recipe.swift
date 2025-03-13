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
    let photoURLStringSmall: String?
    var sourceURL: String?
    var youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoURLStringSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    var id: String {
        uuid
    }
    
    var photoURLSmall: URL? {
        guard let urlString = photoURLStringSmall else {
            return nil
        }

        return URL(string: urlString)
    }
}
