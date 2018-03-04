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
        return stubbedResponse(filename: "Contributors")
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

    //MARK:- Private

    private func stubbedResponse(filename: String) -> Data! {
        class TestClass { }
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")!
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {return  data}
        return  Data()
    }
}
