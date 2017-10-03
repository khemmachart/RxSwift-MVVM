//
//  BaseResponse.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 9/28/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation

open class BaseResponse: NSObject {
    
    open var code: String?
    open var message: String = ""
    
    required public init(object: Any) {
        let object  = object as? [String: Any]
        if let code = object?["code"]    as? String {
            self.code = code
        }
        if let message = object?["message"] as? String {
            self.message = message
        }
    }
    
    required public convenience init(code: String, message: String) {
        self.init(object: [
            "code": code,
            "message": message
            ])
    }
}
