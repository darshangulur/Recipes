//
//  MockAPIClient.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/13/25.
//

import Foundation
@testable import Recipes

struct MockAPIClient: APIClientable {
    func execute<T: Decodable>(routable: any Routable) async throws -> T {
        guard let data = readContentsOfFile(name: routable.urlString) else {
            throw APIError.badURL
        }
        
        let value: T
        do {
            value = try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.parsing
        }
        
        return value
    }
    
    private func readContentsOfFile(name: String) -> Data? {
        guard
            let bundle = Bundle.allBundles.first(where: { $0.bundlePath.contains(".xctest") }),
            let url = bundle.url(forResource: name, withExtension: "json")
        else {
            return nil
        }
        
        let contents = try? String(contentsOfFile: url.path(), encoding: .utf8)
        return contents?.data(using: .utf8)
    }
}
