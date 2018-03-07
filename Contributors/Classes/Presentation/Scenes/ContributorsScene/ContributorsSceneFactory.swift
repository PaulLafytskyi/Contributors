//
//  ContributorsSceneFactory.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/4/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation

class ContributorsSceneFactory {
    static func defaultContributorsScene(navigator: ApplicationNavigator) -> ContributorsViewController {
        let model = ContributorsModel(userManager: UserManagerFactory().defaultUserManager())
        let view = ContributorsViewController()
        let presenter = ContributorsPresenter(view: view, model: model, navigator: navigator)
        view.presenter = presenter
        model.presenter = presenter
        return view
    }
}
