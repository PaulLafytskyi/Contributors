//
//  UserDetailModelSceneFactory.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/7/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation

class UserDetailModelSceneFactory {
    static func userDetailScene (user: User) -> UserDetailViewController {
        let view = UserDetailViewController()
        let presenter = UserDetailPresenter(view: view, user: user)
        view.presenter = presenter
        return view
    }
}
