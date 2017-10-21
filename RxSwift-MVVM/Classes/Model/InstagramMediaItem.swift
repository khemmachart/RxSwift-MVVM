//
//  InstagramMediaItem.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/11/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct InstagramMediaUserModel {
    var id: String?
    var fullName: String?
    var profilePicture: String?
    var username: String?

    init(object: Any?) {
        guard let object = object as? [String: Any] else { return }
        id = object["id"] as? String
        fullName = object["full_name"] as? String
        profilePicture = object["profile_picture"] as? String
        username = object["username"] as? String
    }
}

struct InstagramMediaImageModel {
    var width: Double?
    var height: Double?
    var url: String?

    init(object: Any?) {
        guard let object = object as? [String: Any] else { return }
        width = object["width"] as? Double
        height = object["height"] as? Double
        url = object["url"] as? String
    }
}

struct InstagramMediaImagesTypeModel {
    var thumbnail: InstagramMediaImageModel?
    var lowResolution: InstagramMediaImageModel?
    var standardResolution: InstagramMediaImageModel?

    init(object: Any?) {
        guard let object = object as? [String: Any] else { return }
        thumbnail = InstagramMediaImageModel(object: object["thumbnail"])
        lowResolution = InstagramMediaImageModel(object: object["low_resolution"])
        standardResolution = InstagramMediaImageModel(object: object["standard_resolution"])
    }
}

struct InstagramMediaItemModel {
    var id: String?
    var user: InstagramMediaUserModel?
    var images: InstagramMediaImagesTypeModel?

    init(object: Any) {
        guard let object = object as? [String: Any] else { return }
        id = object["id"] as? String
        user = InstagramMediaUserModel(object: object["user"])
        images = InstagramMediaImagesTypeModel(object: object["images"])
    }
}

extension InstagramMediaItemModel: Equatable {
    
    static func == (lhs: InstagramMediaItemModel, rhs: InstagramMediaItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension InstagramMediaItemModel: IdentifiableType {
    typealias Identity = String
    
    var identity : Identity {
        return id ?? ""
    }
}

struct InstagramMediaSection {
    var id: String = "IUsfJa14"
    var mediaItems: Variable<[InstagramMediaItemModel]> = Variable([])

    init(object: Any) {
        guard let object = object as? [String: Any] else { return }
        if let objects = object["items"] as? [Any] {
            mediaItems.value = objects.map({ InstagramMediaItemModel(object: $0) })
        }
    }
}

extension InstagramMediaSection: SectionModelType, AnimatableSectionModelType {
    typealias Item = InstagramMediaItemModel
    typealias Identity = String
    
    var items: [InstagramMediaItemModel] {
        return mediaItems.value
    }
    var identity: String {
        return id
    }
    
    init(original: InstagramMediaSection, items: [InstagramMediaItemModel]) {
        self = original
        self.mediaItems.value = items
    }
    
    static func == (lhs: InstagramMediaSection, rhs: InstagramMediaSection) -> Bool {
        return lhs.id == rhs.id
    }
}

class InstagramMediaResponse: BaseResponse {
    var section: [InstagramMediaSection] = []

    required init(object: Any) {
        super.init(object: object)
        section = [InstagramMediaSection(object: object)]
    }
}
