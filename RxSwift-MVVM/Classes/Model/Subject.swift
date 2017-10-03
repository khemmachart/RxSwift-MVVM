//
//  Subject.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 9/28/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct Subject {
    var subjectName: String
    var lecturerName: String
    var students: [Student] = []
    
    init(subjectName: String, lecturerName: String, students: [Student]) {
        self.subjectName = subjectName
        self.lecturerName = lecturerName
        self.students = students
    }
}

extension Subject: SectionModelType, AnimatableSectionModelType {
    typealias Item = Student
    typealias Identity = String
    
    var items: [Student] {
        return students
    }
    var identity: String {
        return subjectName
    }
    
    init(original: Subject, items: [Student]) {
        self = original
        self.students = items
    }
    
    static func ==(lhs: Subject, rhs: Subject) -> Bool {
        return lhs.subjectName == rhs.subjectName
    }
}
