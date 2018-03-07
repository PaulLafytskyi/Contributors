//
//  ApplicationAssembly.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/7/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

// MARK:- Protocol

protocol ApplicationAssembly {
    var applicationNavigator: ApplicationNavigator { get }
}

// MARK:- Implementation

class ApplicationAssemblyImpl: ApplicationAssembly {
    private let window: UIWindow
    private let application: UIApplication

    var applicationNavigator: ApplicationNavigator {
        return ApplicationNavigatorLocator.sharedNavigator
    }

    init(window: UIWindow, application: UIApplication) {
        self.window = window
        self.application = application
        setupDependencies()
    }

    private func setupDependencies() {
        ImageDataManagerLocator.populateWithApplicationModel(manager: ImageDataManagerFactory.defaultImageDataManager())
        ApplicationNavigatorLocator.populateWithApplicationNavigator(applicationNavigator: ApplicationNavigatorFactory.defaultApplicationNavigatorWithWindow(window: window))
    }
}

// MARK:- Factory

class ApplicationAssemblyFactory {
    static func defaultAssemblyWithWindow(window: UIWindow, application: UIApplication) -> ApplicationAssembly {
        return ApplicationAssemblyImpl(window: window, application: application)
    }
}
