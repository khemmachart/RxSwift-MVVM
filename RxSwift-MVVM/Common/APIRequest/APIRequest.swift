//
//  APIRequest.swift
//  CheckIn
//
//  Created by Khemmachart Chutapetch on 9/13/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import Alamofire

final class APIRequest: APIRequestProtocol {
    
    // MARK: - API Request
    
    func request(service: FCRouter, handler: @escaping CompletionHandler) -> Request? {
        
        return Alamofire.request(service)
            .logRequest()
            .responseJSON { response in
                
                self.logResponse(response)
                
                switch response.result {
                case .success(let data):
                    guard let json = data as? [String: Any] else { return }
                    if let data = json["data"] {
                        self.successHandler(data, router: service, completionHandler: handler)
                    } else if let error = json["error"] {
                        self.failureHandler(error, completionHandler: handler)
                    } else {
                        self.successHandler(json, router: service, completionHandler: handler)
                    }
                case .failure(let error):
                    let errorJSON = self.generateErrorJSON(error)
                    self.failureHandler(errorJSON, completionHandler: handler)
                }
        }
    }
    
    // MARK: - Completion Handler
    
    func successHandler(_ data: Any, router: FCRouter, completionHandler: APIRequest.CompletionHandler) {
        let instance = router.responseClass.init(object: data)
        completionHandler(instance, nil)
    }
    
    func failureHandler(_ error: Any, completionHandler: APIRequest.CompletionHandler) {
        let instance = BaseResponse(object: error)
        if validate(statusCode: instance.code) {
            completionHandler(nil, instance)
        }
    }
    
    // MARK: - Validation
    
    func validate(statusCode code: String?) -> Bool {
        // To be override
        return true
    }
}
