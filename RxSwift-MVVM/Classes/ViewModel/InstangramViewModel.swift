//
//  InstangramViewModel.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/11/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import RxSwift

class InstagramViewModel {

    var request: APIRequestProtocol = APIRequest()
    
    func requestGetNewsFeedService() -> Observable<[InstagramMediaSection]> {
        return Observable.create { (observer: AnyObserver<[InstagramMediaSection]>) -> Disposable in
            let request = self.request.request(
                router: .newsFeed(userID: "khun9eiei"),
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
