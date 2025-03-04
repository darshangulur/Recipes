//
//  APIClient.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

protocol APIClientable {
    func perform<T: Decodable>(routable: Routable) async -> Result<T, APIError>
}

struct APIClient: APIClientable {
    func perform<T: Decodable>(routable: any Routable) async -> Result<T, APIError> {
        var request = URLRequest(url: routable.url)
        request.httpMethod = routable.httpMethod.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            
        }
        
        return .failure(APIError.network)
    }
}
