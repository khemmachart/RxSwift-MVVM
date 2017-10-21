//
//  InstagramViewController.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/11/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class InstagramViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var dataSource = RxTableViewSectionedReloadDataSource<InstagramMediaSection>()
    let disposeBag = DisposeBag()
    let viewModel = InstagramViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Request news feeds
        viewModel.requestGetNewsFeedService()
            .asObservable()
            .subscribe(onNext: requestNewsFeedServiceDidSuccess())
            .disposed(by: disposeBag)
        
        // Table view delegate
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
        // Configure table view cells
        dataSource.configureCell = { (dataSource, tabelView, indexPath, model) in
            if let cell = tabelView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? InstagramTableViewCell {
                cell.setContent(model)
                return cell
            }
            return  UITableViewCell()
        }
    }
    
    func requestNewsFeedServiceDidSuccess() -> (([InstagramMediaSection]) -> Void)? {
        return { (instagramSections) in
            if self.tableView.dataSource != nil {
                // Reload the table view if data source is exist
                self.dataSource.setSections(instagramSections)
                self.tableView.reloadSections([0], with: .fade)
            } else {
                // Binding the response to the table view
                Observable.just(instagramSections)
                    .asObservable()
                    .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
                    .disposed(by: self.disposeBag)
            }
        }
    }
}

extension InstagramViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
