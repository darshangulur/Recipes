//
//  Routable.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

protocol Routable {
    var url: URL { get }
    var httpMethod: HTTPMethod { get }
}

enum HTTPMethod: String {
    case GET
}
