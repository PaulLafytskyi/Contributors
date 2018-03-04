//
//  GitHubAPIService.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/3/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation
import Moya

typealias SuccessCallback =  (_ result: Response) -> Void
typealias FailureCallback = (_ fail: Error) -> Void

//MARK:- Protocol

protocol GithubApiService {
    var apiProvider: MoyaProvider <GithubAPIRouter> { get }
    func request(router: GithubAPIRouter, success succes: @escaping SuccessCallback, failure: @escaping FailureCallback)
}

//MARK:- Implementation

class GithubApiServiceImplementation: GithubApiService {
    var apiProvider: MoyaProvider<GithubAPIRouter>

    init(stubbing: Bool) {
        let stubClosure = { (target: TargetType) -> Moya.StubBehavior in
            return .immediate
        }
        self.apiProvider = stubbing
            ? MoyaProvider <GithubAPIRouter> (stubClosure: stubClosure)
            : MoyaProvider <GithubAPIRouter> ()
    }

    func request(router: GithubAPIRouter, success succes: @escaping SuccessCallback, failure: @escaping FailureCallback) {
        apiProvider.request(router) { (result) in
            switch result {
            case .success(let response):
                succes(response)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
}

// MARK:- Factory

class GithubApiServiceFactory {
    static func defaultGithubApiService() -> GithubApiService {
        return GithubApiServiceImplementation(stubbing: false)
    }
}
