//
//  APIRequestMock.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/21/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import Alamofire

final class APIRequestMock: APIRequestProtocol {
    
    func request(service: FCRouter, handler: @escaping CompletionHandler) -> Request? {
        return Alamofire.request(service)
    }

    func successHandler(_ data: Any, router: FCRouter, completionHandler: APIRequestProtocol.CompletionHandler) {
        switch router {
        case .newsFeed:
            completionHandler(router.responseClass.init(object: [:]), nil)
        }
    }

    func failureHandler(_ error: Any, completionHandler: APIRequestProtocol.CompletionHandler) {
        // TODO
    }
}
