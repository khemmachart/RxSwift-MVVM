//
//  Student.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 9/26/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import RxDataSources

struct Student {
    var studentID: String
    var name: String

    init(sID: String, name: String) {
        self.studentID = sID
        self.name = name
    }
}

extension Student: Equatable {

    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.studentID == rhs.studentID && lhs.name == rhs.name
    }
}

extension Student: IdentifiableType {
    typealias Identity = String
    
    var identity : Identity {
        return studentID
    }
}
