//
//  NavigationBar.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/23/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    // Navigation Bar
    
    var customBarStyle      : UIBarStyle = .default
    var customBarTintColor  : UIColor = .white
    var customTintColor     : UIColor = .black
    var customIsTranslucent : Bool = false;
    
    var barFontAttributeName  : UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    var itemFontAttributeName : UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    var barForegroundColorAttributeName  : UIColor = .black
    var itemForegroundColorAttributeName : UIColor = .black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setInterface()
    }
    
    // MARK: - Interface
    
    func setInterface() {
        setBarProperties()
        setBarItemsFont()
        setBarFont()
    }
    
    func setBarItemsFont() {
        let attributes: [String: Any] = [
            NSFontAttributeName: barFontAttributeName,
            ]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
    
    func setBarFont() {
        titleTextAttributes = [
            NSFontAttributeName: barFontAttributeName,
            NSForegroundColorAttributeName: barForegroundColorAttributeName
        ]
    }
    
    func setBarLightContent() {
        titleTextAttributes = [
            NSFontAttributeName: barFontAttributeName,
            NSForegroundColorAttributeName: UIColor.white
        ]
    }
    
    func setBarProperties() {
        barStyle      = customBarStyle
        barTintColor  = customBarTintColor
        tintColor     = customTintColor
        isTranslucent = customIsTranslucent
        
        setBackgroundImage(UIImage(named: ""), for: .default)
        shadowImage = UIImage(named: "")
    }
    
    func setBarOpaque() {
        setBarProperties()
    }
    
    func setBarDefaultContent() {
        setBarFont()
    }
    
    func setBarTranslucent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
}
