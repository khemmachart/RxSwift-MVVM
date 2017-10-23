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
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News Feed"
        
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

    /// MARK: - Request handlers
    
    func requestNewsFeedServiceDidSuccess() -> (([InstagramMediaSection]) -> Void)? {
        return { (instagramSections) in

            // If the data source is exist, we update it instead of create new onw
            if self.tableView.dataSource != nil,
                // Optional binding
                let firstSection = self.dataSource.sectionModels.first,
                let instagramSection = instagramSections.first {
                
                // Set the new items to section, it has to be created a new one
                let combindedItems = firstSection.items + instagramSection.items
                let newSecion = InstagramMediaSection(original: firstSection, items: combindedItems)

                // Reload the table view
                self.dataSource.setSections([newSecion])
                self.tableView.reloadSections([0], with: .none)

            } else {
                // Binding the response to the table view
                Observable.just(instagramSections)
                    .asObservable()
                    .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
                    .disposed(by: self.disposeBag)
            }
        }
    }
    
    // MARK: - Action

    @IBAction private func editButtonDidPress(_ sender: UIBarButtonItem) {
        presentSettingView()
    }

    // MAKR: - Utils

    private func presentSettingView() {
        let sName = "Main"
        let sID = "DataSourceViewController"
        let stroyboard = UIStoryboard(name: sName, bundle: nil)
        if let viewController = stroyboard.instantiateViewController(withIdentifier: sID) as? DataSourceViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
