//
//  GithubAPIRequestManagerSpec.swift
//  ContributorsTests
//
//  Created by Poul Lafitskiy on 3/4/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import Contributors

class GithubAPIRequestManagerSpec: QuickSpec {

    override func spec() {

        describe("GithubAPIRequestManagerSpec", closure: {
            var sut: GitHubAPIRequestManager!
            var apiService: GithubApiService!

            describe("When initialized", {
                beforeEach {
                    apiService = GithubApiServiceImplementation(stubbing: true)
                    sut = GitHubAPIRequestManagerImplementation(apiService: apiService)
                }
                describe("When ask for contributors", {
                    it("Should return value", closure: {
                        var error: Error? = nil
                        waitUntil { done in
                            sut.getContributors(owner: "we don't care about string", repo: "we don't care about string", success: { userList  in
                                expect(userList.count == 30).to(beTrue())
                                done()
                            }, failure: { failure in
                                error = failure
                                done()
                            })
                        }
                        expect(error).to(beNil())
                    })
                })
            })
        })
    }
}

