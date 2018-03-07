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
    case downloadImage(url: URL)
}

extension GithubAPIRouter: TargetType {

    var baseURL: URL {
        switch self {
        case .contributors:
            return Configurations.url
        case .downloadImage(let url):
            return url
        }
    }

    var path: String {
        switch self {
        case .contributors(let owner, let repo):
            return "repos/\(owner)/\(repo)/contributors"
        case .downloadImage:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .contributors, .downloadImage:
            return .get
        }
    }

    var sampleData: Data {
        return stubbedResponse(filename: "Contributors")
    }

    var task: Task {
        switch self {
        case .contributors, .downloadImage:
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
