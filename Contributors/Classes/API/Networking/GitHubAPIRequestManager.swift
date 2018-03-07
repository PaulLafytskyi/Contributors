//
//  GitHubAPIRequestManager.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/3/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation
import Moya

//MARK:- Protocol

protocol GitHubAPIRequestManager {
    var apiService: GithubApiService { get }
    func getContributors(owner: String, repo: String, success: @escaping SuccessUsersCompletionBlock, failure: @escaping ErrorCompletionBlock)
}

//MARK:- Implementation

class GitHubAPIRequestManagerImplementation: GitHubAPIRequestManager {
    var apiService: GithubApiService

    init(apiService: GithubApiService) {
        self.apiService = apiService
    }

    func getContributors(owner: String, repo: String, success: @escaping SuccessUsersCompletionBlock, failure: @escaping ErrorCompletionBlock) {
        apiService.request(router: .contributors(owner: owner, repo: repo), success: { (response) in
            let decoder = JSONDecoder()
            do {
            let userList = try decoder.decode([User].self, from: response.data)
                success(userList)
            }
            catch {
                failure(GithubError.invalidResponse)
            }

        }) { (_) in
            failure(GithubError.networkError)
        }
    }
}

//MARK:- Factory

class GitHubAPIRequestManagerFactory {

    static func defaultApiRequestManager() -> GitHubAPIRequestManager {
        return GitHubAPIRequestManagerImplementation(apiService: GithubApiServiceFactory.defaultGithubApiService())
    }
}
