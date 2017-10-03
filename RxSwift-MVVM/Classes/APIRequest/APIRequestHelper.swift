//
//  APIRequestHelper.swift
//  CheckIn
//
//  Created by Khemmachart Chutapetch on 9/13/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Alamofire

extension APIRequest {
    
    public static func generateErrorJSON(_ error: Error) -> [String: String] {
        let statusCode = "\(error._code)"
        let generatedMessage = generateErrorMessage(error)
        let defaultMessage   = error.localizedDescription
        return [
            "code": statusCode,
            "message": defaultMessage
        ]
    }
    
    public static func generateErrorMessage(_ error: Error) -> String {
        
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                return "Invalid URL: \(url) - \(error.localizedDescription)"
            case .parameterEncodingFailed(let reason):
                return "Parameter encoding failed: \(error.localizedDescription). Failure Reason: \(reason)"
            case .multipartEncodingFailed(let reason):
                return "Multipart encoding failed: \(error.localizedDescription). Failure Reason: \(reason)"
            case .responseValidationFailed(let reason):
                let prefix = "Response validation failed: \(error.localizedDescription). Failure Reason: \(reason)"
                
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    return prefix + "Downloaded file could not be read"
                case .missingContentType(let acceptableContentTypes):
                    return prefix + "Content Type Missing: \(acceptableContentTypes)"
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    return prefix + "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                case .unacceptableStatusCode(let code):
                    return prefix + "Response status code was unacceptable: \(code)"
                }
                
            case .responseSerializationFailed(let reason):
                return "Response serialization failed: \(error.localizedDescription). Failure Reason: \(reason)"
            }
        }
        else if let error = error as? URLError {
            return "URLError occurred: \(error)"
        }
        else {
            return "Unknown error: \(error)"
        }
    }
}
