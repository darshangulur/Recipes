//
//  FoundationExtensionTests.swift
//  RecipesTests
//
//  Created by Darshan Gulur Srinivasa on 3/14/25.
//

import Foundation
import Testing
@testable import Recipes

struct FoundationExtensionTests {
    @Test(
        "Test HTTPURLResponse Status Code",
        arguments: [
            200, 201, 299, 300, 199, 500
        ]
    )
    func testHTTPURLResponse(statusCode: Int) {
        let expectedResponse = HTTPURLResponse.successStatusCodeRange.contains(statusCode)
        let response = HTTPURLResponse(
            url: URL(string: "https://www.fetch.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
        #expect(response?.isSuccess == expectedResponse)
    }
    
    @Test(
        "String to NSString cast"
    )
    func testStringToNSString() async throws {
        let value = "value"
        #expect(value.description == value.nsString.description)
    }
    
    @Test(
        "String to URL conversion"
    )
    func testStringToURL() async throws {
        var urlString: String? = "https://www.fetch.com"
        #expect(urlString.url == URL(string: urlString!)!)
        
        urlString = ""
        #expect(urlString.url == nil)
    }
}
