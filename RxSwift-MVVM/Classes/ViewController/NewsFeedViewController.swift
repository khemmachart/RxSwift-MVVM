//
//  NewsFeedViewController.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/21/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class NewsFeedViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var dataSource = RxTableViewSectionedReloadDataSource<InstagramMediaSection>()
    let disposeBag = DisposeBag()
    var viewModel: NewsFeedViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Request news feeds
        for userID in InstagramUserManager.shared.getAllUser() {
            viewModel.requestGetNewsFeedService(userID: userID)
                .asObservable()
                .subscribe(onNext: requestNewsFeedServiceDidSuccess())
                .disposed(by: disposeBag)
        }
        
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
                // Reload the table view just only the new section
                let combindedSections = self.dataSource.sectionModels + instagramSections
                self.dataSource.setSections(combindedSections)
                self.tableView.reloadData()
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

extension NewsFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
