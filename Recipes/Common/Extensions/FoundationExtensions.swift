//
//  FoundationExtensions.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/12/25.
//

import Foundation

extension HTTPURLResponse {
    var isSuccess: Bool {
        (200...299).contains(statusCode) // HTTP success status code range check
    }
}

extension String {
    var nsString: NSString {
        NSString(string: self)
    }
}
