//
//  FCRouterResponseClass.swift
//  TCApp
//
//  Created by KHUN NINE on 5/11/17.
//  Copyright © 2017 Khemmachart Chutapetch. All rights reserved.
//

extension FCRouter {

    var responseClass: BaseResponse.Type {
        switch self {
        case .newsFeed:
            return BaseResponse.self
        }
    }
}
