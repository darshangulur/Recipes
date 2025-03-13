//
//  APIClient.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/4/25.
//

import Foundation

protocol APIClientable {
    func execute<T: Decodable>(routable: Routable) async throws -> T
}

struct APIClient: APIClientable {
    func execute<T: Decodable>(routable: any Routable) async throws -> T {
        guard let url = routable.url else {
            throw APIError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = routable.httpMethod.rawValue
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw APIError.request
        }
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.isSuccess
        else {
            throw APIError.httpError
        }
        
        let value: T
        do {
            value = try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.parsing
        }
        
        return value
    }
}
