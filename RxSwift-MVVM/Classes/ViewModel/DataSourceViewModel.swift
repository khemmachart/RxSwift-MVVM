//
//  DataSourceViewModel.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 9/25/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import RxSwift

class DataSourceViewModel {

    // MARK: - APIs

    func requestGetNewsFeedService() -> Observable<[Subject]> {
        return Observable.create { (observer: AnyObserver<[Subject]>) -> Disposable in
            let request = APIRequest.request(
                router: .newsFeed(userID: "khun9eiei"),
                handler: self.handleGetNewsFeedService(observer: observer))
            return Disposables.create(with: {
                request?.cancel()
            })
        }
    }

    func requestDeleteNewsFeedService(at index: Int) -> Observable<Bool> {
        return Observable.create { (observer: AnyObserver<Bool>) -> Disposable in
            let request = APIRequest.request(
                router: .newsFeed(userID: "khun9eiei"),
                handler: self.handleDeleteNewsFeedService(at: index, observer: observer))
            return Disposables.create(with: {
                request?.cancel()
            })
        }
    }

    // MARK: - Handlers

    private func handleGetNewsFeedService(observer: AnyObserver<[Subject]>) -> APIRequest.CompletionHandler {
        return { (response, error) in
            if response != nil {
                observer.onNext([
                    Subject(
                        subjectName: "Java Programming",
                        lecturerName: "Chonlameth",
                        students: [
                            Student(sID: "55130500205", name: "Khemmachart"),
                            Student(sID: "55130500206", name: "Jirayu"),
                            Student(sID: "55130500207", name: "Chularak"),
                            Student(sID: "55130500222", name: "Peerapon"),
                            Student(sID: "55130500252", name: "Pahn"),
                            ]),
                    Subject(
                        subjectName: "Foundation",
                        lecturerName: "Chonlameth",
                        students: [
                            Student(sID: "55130500223", name: "Puttapong"),
                            Student(sID: "55130500235", name: "Adisak"),
                            Student(sID: "55130500242", name: "Panas"),
                            Student(sID: "55130500249", name: "Ritthikiat"),
                            Student(sID: "55130500247", name: "Apikrit"),
                            ])
                ])  
            }
        }
    }

    private func handleDeleteNewsFeedService(at index: Int, observer: AnyObserver<Bool>) -> APIRequest.CompletionHandler {
        return { (response, error) in
            if response != nil {
                observer.onNext(true)
            } else if error != nil {
                observer.onNext(false)
            }
        }
    }
}
