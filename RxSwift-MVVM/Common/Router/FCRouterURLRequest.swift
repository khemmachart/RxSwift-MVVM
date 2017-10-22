//
//  FCRouterURLRequest.swift
//  TCApp
//
//  Created by KHUN NINE on 5/11/17.
//  Copyright © 2017 Khemmachart Chutapetch. All rights reserved.
//

import Alamofire

extension FCRouter {

    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLString + path)!
        var mutableURLRequest = URLRequest(url: url)
        mutableURLRequest.httpMethod = method.rawValue
        mutableURLRequest.httpBody = rawBody as Data
        FCRouterHelper().setHttpHeaders(&mutableURLRequest, headers: headers)

        return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: parameters)
    }
}
