//
//  FoundationExtensions.swift
//  Recipes
//
//  Created by Darshan Gulur Srinivasa on 3/12/25.
//

import Foundation

extension HTTPURLResponse {
    static var successStatusCodeRange: ClosedRange<Int> {
        (200...299)
    }
    
    var isSuccess: Bool {
        HTTPURLResponse.successStatusCodeRange.contains(statusCode)
    }
}

extension String {
    var nsString: NSString {
        NSString(string: self)
    }
}

extension String? {
    var url: URL? {
        guard let urlString = self else {
            return nil
        }
        
        return URL(string: urlString)
    }
}
