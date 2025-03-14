//
//  Routable.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

protocol Routable {
    var urlString: String { get }
    var httpMethod: HTTPMethod { get }
}

extension Routable {
    var url: URL? {
        URL(string: urlString)
    }
}

enum HTTPMethod: String {
    case GET
}
