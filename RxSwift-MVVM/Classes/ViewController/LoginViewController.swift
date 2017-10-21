//
//  LoginViewController.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 9/22/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

    private lazy var viewModel: LoginViewModel = LoginViewModel()

    private let disposeBag = DisposeBag()

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupObservers()
    }

    // MARK: - Interface

    private func setupInterface() {
        loginButton.setTitleColor(.lightGray, for: .disabled)
        loginButton.setTitleColor(.white, for: .normal)
    }

    // MARK: - Rx setup

    private func setupObservers() {
        usernameTextField.rx.text
            .map({ $0 ?? "" })
            .bind(to: viewModel.usernameText)
            .addDisposableTo(disposeBag)

        passwordTextField.rx.text
            .map({ $0 ?? "" })
            .bind(to: viewModel.passwordText)
            .addDisposableTo(disposeBag)

        viewModel.isValidInput
            .asObservable()
            .bind(to: loginButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }

    // MARK: - Action

    @IBAction private func loginButtonDidPress(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Login success", preferredStyle: .alert)
        alert.addAction(loginAlertButtonAction)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Utils

    private var loginAlertButtonAction: UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.presentDataSourceViewController()
        })
    }

    private func presentDataSourceViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DataSourceViewController")
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }
}
