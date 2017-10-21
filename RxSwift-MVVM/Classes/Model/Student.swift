//
//  Student.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 9/26/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

struct Student {
    var studentID: Variable<String> = Variable("")
    var name: Variable<String> = Variable("")

    init(sID: String, name: String) {
        self.studentID.value = sID
        self.name.value = name
    }
}

extension Student: Equatable {

    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.studentID.value == rhs.studentID.value && lhs.name.value == rhs.name.value
    }
}

extension Student: IdentifiableType {
    typealias Identity = String
    
    var identity : Identity {
        return studentID.value
    }
}
