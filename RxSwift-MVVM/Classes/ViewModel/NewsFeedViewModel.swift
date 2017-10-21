//
//  NewsFeedViewModel.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/21/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import Alamofire

class NewsFeedViewModel {

    var request: APIRequestProtocol

    init(APIRequest request: APIRequest) {
        self.request = request
    }

    // MARK: - APIs

    func requestNewsFeedService() {
        _ = request.request(service: .newsFeed(userID: "khun9eiei"), handler: handleNewsFeedService())
    }

    // MARK: - Handler

    private func handleNewsFeedService() -> APIRequestProtocol.CompletionHandler {
        return { (response, error) in
            
        }
    }
}
