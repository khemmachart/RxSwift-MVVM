//
//  NewsFeedViewModel.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/21/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class NewsFeedViewModel {

    var request: APIRequestProtocol

    // MARK: - Initialization

    init(APIRequest request: APIRequestProtocol) {
        self.request = request
    }

    // MARK: - APIs
    
    func requestGetNewsFeedService(userID: String) -> Observable<[InstagramMediaSection]> {
        return Observable.create { (observer: AnyObserver<[InstagramMediaSection]>) -> Disposable in
            let request = self.request.request(
                service: .newsFeed(userID: userID),
                handler: self.handleGetNewsFeedService(observer: observer))
            return Disposables.create(with: {
                request?.cancel()
            })
        }
    }
    
    private func handleGetNewsFeedService(observer: AnyObserver<[InstagramMediaSection]>) -> APIRequestProtocol.CompletionHandler {
        return { (response, error) in
            if let response = response as? InstagramMediaResponse {
                observer.onNext(response.section)
            }
        }
    }
}
