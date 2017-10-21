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
        setInitialViewController(window: &window)
        return true
    }
}

extension AppDelegate {

    func setInitialViewController(window: inout UIWindow?) {
        if let initialViewController = getNewsFeedViewController() {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
        }
    }

    private func getNewsFeedViewController() -> NewsFeedViewController? {
        let storyboard = UIStoryboard(name: "NewsFeed", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "NewsFeedViewController") as? NewsFeedViewController {
            viewController.viewModel = NewsFeedViewModel(APIRequest: APIRequest())
            return viewController
        }
        return nil
    }
}

