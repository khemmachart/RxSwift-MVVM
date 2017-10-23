//
//  AppDelegate.swift
//  RxSwiftMVVM
//
//  Created by Khemmachart Chutapetch on 9/22/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setMainViewController(window: &window)
        return true
    }
}

extension AppDelegate {

    func setMainViewController(window: inout UIWindow?) {
        if let initialViewController = getInitialViewController() {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
        }
    }

    private func getInitialViewController() -> UIViewController? {
        let storyboard = UIStoryboard(name: "NewsFeed", bundle: nil)
        if let navController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as? NavigationController,
            let viewController = navController.viewControllers.first as? NewsFeedViewController {
            viewController.viewModel = NewsFeedViewModel(APIRequest: APIRequest())
            return navController
        }
        return nil
    }
}

