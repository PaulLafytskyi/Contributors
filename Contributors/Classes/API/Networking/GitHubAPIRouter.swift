//
//  GitHubAPIRouter.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/3/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation
import Moya

enum GithubAPIRouter {
    case contributors(owner: String, repo: String)
}

extension GithubAPIRouter: TargetType {
    var baseURL: URL {
        return Configurations.url
    }

    var path: String {
        switch self {
        case .contributors(let owner, let repo):
            return "repos/\(owner)/\(repo)/contributors"
        }
    }

    var method: Moya.Method {
        switch self {
        case .contributors:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .contributors:
            return.requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
