//
//  APIRequestProtocol.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/21/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Protocol

protocol APIRequestProtocol {

    typealias CompletionHandler = (_ Response: BaseResponse?, _ Error: BaseResponse?) -> Void

    func request(router: FCRouter, handler: @escaping CompletionHandler) -> Request?
    func successHandler(_ data: Any, router: FCRouter, completionHandler: APIRequestProtocol.CompletionHandler)
    func failureHandler(_ error: Any, completionHandler: APIRequestProtocol.CompletionHandler)
}

// MARK: - Log Response

extension APIRequestProtocol {
    
    public func logResponse(_ aResponse: DataResponse<Any>) {
        if let response = aResponse.response {
            logDivider()
            logPath(URL: response.url, withKey: "Response")
            logStatus(httpResponse: response)
            logHeaders(headers: response.allHeaderFields)
            logJSON(data: aResponse.data)
            logDivider()
        }
        
        /*
         if let startDate = Timberjack.propertyForKey(TimberjackRequestTimeKey, inRequest: newRequest!) as? NSDate {
         let difference = fabs(startDate.timeIntervalSinceNow)
         print("Duration: \(difference)s")
         }
         */
    }
}

// MARK: - Utiles

extension APIRequestProtocol {
    
    public func logPath(URL: URL?, withKey key: String) {
        if let URL = URL {
            print("\(key): \(URL.absoluteString)")
        }
    }
    
    public func logStatus(httpResponse: HTTPURLResponse) {
        let localisedStatus = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode).capitalized
        print("Status: \(httpResponse.statusCode) - \(localisedStatus)")
    }
    
    public func logHeaders(headers: Any?) {
        if let headers = headers as? [String: AnyObject] {
            print("Headers: [")
            for (key, value) in headers {
                print("  \(key): \(value)")
            }
            print("]")
        }
    }
    
    public func logJSON(data: Data?) {
        guard let data = data else { return }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let pretty = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
                print("JSON: \(string)")
            }
        }
        catch {
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                print("Data: \(string)")
            }
        }
    }
    
    public func logHTTPMethod(request: URLRequest) {
        if let method = request.httpMethod {
            print("Method: \(method)")
        }
    }
    
    public func logDivider() {
        print("-------------------------------------------------------------------------------------------------")
    }
}
