//
//  LoginViewModel.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 9/22/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {

    var usernameText: Variable<String> = Variable("")
    var passwordText: Variable<String> = Variable("")
    var isValidInput: Observable<Bool> {
        return Observable.combineLatest(
            usernameText.asObservable(), passwordText.asObservable(),
            resultSelector: { (usernameText, passwordText) -> Bool in
                return usernameText.characters.count > 5 && passwordText.characters.count > 5
        })
    }
}
