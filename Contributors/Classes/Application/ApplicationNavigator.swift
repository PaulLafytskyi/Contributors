//
//  ApplicationNavigator.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/7/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

// MARK:- Protocol

protocol ApplicationNavigator: AnyObject {
    func navigateToCurrentApplicationState()
    func navigateToScreen(screen: UIViewController)
}

// MARK:- Implementation

class ApplicationNavigatorImpl: ApplicationNavigator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func navigateToCurrentApplicationState() {
        let navigationController = UINavigationController()
        navigationController.setViewControllers([ContributorsSceneFactory.defaultContributorsScene(navigator: self)], animated: true)
        window.rootViewController = navigationController
    }

    func navigateToScreen(screen: UIViewController) {
        if let rootNavigation = window.rootViewController as? UINavigationController {
            rootNavigation.pushViewController(screen, animated: true)
        }
    }
}

// MARK:- Factory

class ApplicationNavigatorFactory {
    static func defaultApplicationNavigatorWithWindow(window: UIWindow) -> ApplicationNavigator {
        return ApplicationNavigatorImpl(window: window)
    }
}

// MARK:- Service Locator

class ApplicationNavigatorLocator {
    private static var applicationNavigator: ApplicationNavigator?

    static func populateWithApplicationNavigator(applicationNavigator: ApplicationNavigator) {
        ApplicationNavigatorLocator.applicationNavigator = applicationNavigator
    }

    static var sharedNavigator: ApplicationNavigator {
        return ApplicationNavigatorLocator.applicationNavigator!
    }
}
