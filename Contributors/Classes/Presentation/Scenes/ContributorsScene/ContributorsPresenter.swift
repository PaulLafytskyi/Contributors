//
//  ContributorsPresenter.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/4/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

protocol ContributorsViewPresenter {
    func viewDidReady()
    func numberOfRow() -> Int
    func dataAtIndex(index: Int) -> User?
    func didSelectItemAtIndex(index: Int)
}

protocol ContributorsModelPresenter: AnyObject {
    func newDataAppear(data: [User])
    func failedToLoadData()
}

class ContributorsPresenter: ContributorsViewPresenter, ContributorsModelPresenter {
    unowned var view: ContributorsView
    unowned var navigator: ApplicationNavigator
    var model: ContributorsModel
    var userList: [User] = [User] ()

    //MARK:- Init

    init(view: ContributorsView, model: ContributorsModel, navigator: ApplicationNavigator) {
        self.view = view
        self.model = model
        self.navigator = navigator
    }

    //MARK:- ContributorsViewPresenter

    func viewDidReady() {
        model.loadData()
    }

    func numberOfRow() -> Int {
        return userList.count
    }

    func dataAtIndex(index: Int) -> User? {
        return userList[index]
    }

    func didSelectItemAtIndex(index: Int) {
        let user = userList[index]
        navigator.navigateToScreen(screen: UserDetailModelSceneFactory.userDetailScene(user: user))
    }

    //MARK:- ContributorsModelPresenter

    func newDataAppear(data: [User]) {
        userList = data
        DispatchQueue.main.async {
            self.view.makeUpdate()
        }
    }

    func failedToLoadData() {
        
    }
}
