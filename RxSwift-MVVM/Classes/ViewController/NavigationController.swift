//
//  NavigationController.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/23/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    // Navigation Bar
    
    var barStyle      : UIBarStyle = .default
    var barTintColor  : UIColor = .white
    var tintColor     : UIColor = .black
    var isTranslucent : Bool = false;
    
    // MARK: - Interface
    
    func setNavigationBarNormal() {
        if let navBar = navigationBar as? NavigationBar {
            navBar.setInterface()
        }
    }
    
    func setNavBarLightContent() {
        if let navBar = navigationBar as? NavigationBar {
            navBar.setBarLightContent()
        }
    }
    
    func setNavigationBarTranslucent() {
        if let navBar = navigationBar as? NavigationBar {
            navBar.setBarTranslucent()
        }
    }
}

// MARK: - Status bar

extension NavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let visibleVC = visibleViewController {
            return visibleVC.preferredStatusBarStyle
        }
        return super.preferredStatusBarStyle
    }
}

// MARK: - Orientation

extension NavigationController {
    
    override var shouldAutorotate: Bool {
        if let visibleVC = visibleViewController {
            return visibleVC.shouldAutorotate
        }
        return super.shouldAutorotate
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        if let visibleVC = visibleViewController {
            return visibleVC.preferredInterfaceOrientationForPresentation
        }
        return super.preferredInterfaceOrientationForPresentation
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if let visibleVC = visibleViewController {
            return visibleVC.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }
}
