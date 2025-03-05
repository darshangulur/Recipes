//
//  APIError.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

enum APIError: Error {
    case badURL
    case request
    case httpError
    case parsing
    
    var message: String {
        switch self {
        case .badURL: "URL is invalid. Please try again with a valid URL."
        case .request: "Request failed. Please verify the request parameters and try again."
        case .httpError: "Request failed due to a server error. Please try again later."
        case .parsing: "Found an error while parsing data. Please check the data model."
        }
    }
}
