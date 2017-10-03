//
//  RouterHeaders.swift
//  grokRouter
//
//  Created by Khemmachart Chutapetch on 7/31/2559 BE.
//  Copyright © 2559 Teak Mobile Inc. All rights reserved.
//

import Foundation
import Alamofire

open class FCRouterHelper: NSObject {

    public func setHttpHeaders(_ mutableURLRequest: inout URLRequest, headers: [String: String]?) {
        addDefaultHttpHeader(&mutableURLRequest)
        if let headers = headers {
            for each in headers.keys {
                mutableURLRequest.setValue(headers[each], forHTTPHeaderField: each)
            }
        }
    }

    open func addDefaultHttpHeader(_ mutableURLRequest: inout URLRequest) {
        // To be overrided
    }
}
