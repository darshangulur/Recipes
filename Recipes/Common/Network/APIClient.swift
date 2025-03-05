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
        var request = URLRequest(url: routable.url)
        request.httpMethod = routable.httpMethod.rawValue
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw APIError.badURL
        }
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw APIError.network
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
