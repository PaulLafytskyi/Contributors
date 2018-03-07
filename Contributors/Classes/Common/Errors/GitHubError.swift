//
//  GitHubError.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/8/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation

enum GithubError: Error {
    case invalidResponse
    case networkError
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid Response"
        case .networkError:
            return "The request was unsuccessful"
        }
    }
}



