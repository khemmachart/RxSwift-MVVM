//
//  FCRouterMethod.swift
//  TCApp
//
//  Created by KHUN NINE on 5/11/17.
//  Copyright © 2017 Khemmachart Chutapetch. All rights reserved.
//

import Alamofire

extension FCRouter {

    var method: Alamofire.HTTPMethod {
        switch self {
        case .newsFeed:
            return .get
        }
    }
}
