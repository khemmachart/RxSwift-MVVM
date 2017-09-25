//
//  DataSourceViewController.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 9/25/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class DataSourceViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    let viewModel = DataSourceViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel
            .data
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell"), curriedArgument: { index, model, cell in
                cell.textLabel?.text = model
            })
            .disposed(by: disposeBag)
    }
}
