//
//  FCRouterBaseURLString.swift
//  TCApp
//
//  Created by KHUN NINE on 5/11/17.
//  Copyright © 2017 Khemmachart Chutapetch. All rights reserved.
//

import Foundation

extension FCRouter {

    var baseURLString: String {
        switch self {
        case .newsFeed:
            return "https://www.instagram.com"
        }
    }
}
