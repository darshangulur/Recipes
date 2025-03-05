//
//  APIError.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

enum APIError: Error {
    case badURL
    case network
    case parsing
}
