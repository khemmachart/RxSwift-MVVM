//
//  FCRouterPath.swift
//  TCApp
//
//  Created by KHUN NINE on 5/11/17.
//  Copyright © 2017 Khemmachart Chutapetch. All rights reserved.
//

import Foundation

extension FCRouter {

    var path: String {
        switch self {
        case .newsFeed(let userID):
            return "/\(userID)/media/"
        }
    }
}
