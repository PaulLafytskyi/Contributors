//
//  ContributorsModel.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/4/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation

class ContributorsModel {
    var userManager: UserManager
    weak var presenter: ContributorsModelPresenter?

    init(userManager: UserManager) {
        self.userManager = userManager
    }

    func loadData() {
        userManager.getContributors(ownerName:Configurations.repoOwner, repoName: Configurations.repoName, succes: { (users) in
            self.presenter?.newDataAppear(data: users)
        }) { (error) in
            self.presenter?.failedToLoadData()
        }
    }
}
