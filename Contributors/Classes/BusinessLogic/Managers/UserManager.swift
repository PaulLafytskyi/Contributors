//
//  UserManager.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/3/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation

typealias SuccessUsersCompletionBlock = (_ characters: [User]) -> Void
typealias ErrorCompletionBlock = (Error) -> Void

//MARK:- Protocol

protocol UserManager {
    var requestManager: GitHubAPIRequestManager { get }
    func getContributors(ownerName: String, repoName: String,
                         succes: @escaping SuccessUsersCompletionBlock,
                         failure: @escaping ErrorCompletionBlock)
}

//MARK:- Implementation

class UserManagerImplementation: UserManager {
    var requestManager: GitHubAPIRequestManager

    init(requestManager: GitHubAPIRequestManager) {
        self.requestManager = requestManager
    }

    func getContributors(ownerName: String, repoName: String,
                         succes: @escaping SuccessUsersCompletionBlock,
                        failure: @escaping ErrorCompletionBlock) {
        requestManager.getContributors(owner: ownerName, repo: repoName, success: { (user) in
            succes(user)
        }) { (eror) in
            failure(eror)
        }
    }
}

//MARK:- Factory

class UserManagerFactory {
    func defaultUserManager() -> UserManager {
        return UserManagerImplementation(requestManager: GitHubAPIRequestManagerFactory.defaultApiRequestManager())
    }
}
