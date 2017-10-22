//
//  APIRequestDebugger.swift
//  CheckIn
//
//  Created by Khemmachart Chutapetch on 9/13/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Log Request

extension DataRequest {
    
    public func logRequest() -> DataRequest {
        if let request = self.request {
            let serviceReq = APIRequest()
            serviceReq.logDivider()
            serviceReq.logPath(URL: request.url, withKey: "Request")
            serviceReq.logHTTPMethod(request: request)
            serviceReq.logHeaders(headers: request.allHTTPHeaderFields)
            serviceReq.logJSON(data: request.httpBody)
            serviceReq.logDivider()
        }
        return self
    }
}
