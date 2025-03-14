//
//  APIErrorTests.swift
//  RecipesTests
//
//  Created by Darshan Gulur Srinivasa on 3/14/25.
//

import Testing
@testable import Recipes

struct APIErrorTests {

    @Test func testAPIErrors() async throws {
        #expect(APIError.badURL.message == "URL is invalid. Please try again with a valid URL.")
        #expect(APIError.request.message == "Request failed. Please verify the request parameters and try again.")
        #expect(APIError.httpError.message == "Request failed due to a server error. Please try again later.")
        #expect(APIError.parsing.message == "Found an error while parsing data. Please check the data model.")
    }

}
