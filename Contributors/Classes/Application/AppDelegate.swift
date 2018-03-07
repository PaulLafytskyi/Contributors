//
//  AppDelegate.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/3/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationAssembly: ApplicationAssembly!
    var applicationNavigator: ApplicationNavigator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupMainWindow()
        setupApplicationDependencies(application: application)
        applicationNavigator.navigateToCurrentApplicationState()
        return true
    }


    private func setupMainWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }

    private func setupApplicationDependencies(application: UIApplication) {
        applicationAssembly = ApplicationAssemblyFactory.defaultAssemblyWithWindow(window: window!, application: application)
        applicationNavigator = applicationAssembly.applicationNavigator
    }
}
