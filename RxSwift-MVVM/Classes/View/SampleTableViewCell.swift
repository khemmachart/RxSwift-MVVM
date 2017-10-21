//
//  SampleTableViewCell.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/3/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SampleTableViewCell: UITableViewCell {
    @IBOutlet weak var sIDLabel: UILabel!
    @IBOutlet weak var sNameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    private var disposeBag = DisposeBag()

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }

    func setContent(_ content: Student) {
        content.name.asObservable().bind(to: sNameLabel.rx.text).disposed(by: disposeBag)
        content.studentID.asObservable().bind(to: sIDLabel.rx.text).disposed(by: disposeBag)
        content.studentID.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)

        textField
            .rx.textInput.text.orEmpty
            .bind(to: content.studentID)
            .disposed(by: disposeBag)
    }
}
