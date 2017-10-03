//
//  FCRouter.swift
//  TCApp
//
//  Created by KHUN NINE on 5/11/17.
//  Copyright © 2017 Khemmachart Chutapetch. All rights reserved.
//

import Alamofire

enum FCRouter: URLRequestConvertible {

    case newsFeed(userID: String)
}
