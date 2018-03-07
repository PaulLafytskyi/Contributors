//
//  UserDetailPresenter.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/7/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation

protocol UserDetailViewPresenter {
    func viewDidReady()
}

class UserDetailPresenter: UserDetailViewPresenter{
    unowned var view: UserDetailView
    var user: User

    init(view: UserDetailView, user: User) {
        self.view = view
        self.user = user
    }

    //MARK:- UserDetailViewPresenter

    func viewDidReady() {
        view.configure(image: user.avatar, name: user.login)
    }
}
