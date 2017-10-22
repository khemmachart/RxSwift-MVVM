//
//  SettingViewController.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/23/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var label: UILabel!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
    }
    
    // MARK: - Interface

    private func setLabel() {
        label.text = ""
        for user in InstagramUserManager.shared.getAllUser() {
            label.text = label.text! + user + ", "
        }
    }

    @IBAction private func buttonDidPress(_ sender: UIButton) {
        if let text = textField.text, text.characters.count > 0 {
            InstagramUserManager.shared.append(user: text)
            textField.text = ""
            setLabel()
        }
    }
}
