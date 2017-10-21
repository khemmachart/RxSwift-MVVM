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

    var dataSource = RxTableViewSectionedReloadDataSource<Subject>()
    let disposeBag = DisposeBag()
    let viewModel = DataSourceViewModel()
    
    func requestNewsFeedServiceDidSuccess() -> (([Subject]) -> Void)? {
        return { (subjects) in
            if self.tableView.dataSource != nil {
                // Reload the table view if data source is exist
                self.dataSource.setSections(subjects)
                self.tableView.reloadSections([0], with: .fade)
            } else {
                // Binding the response to the table view
                Observable.just(subjects)
                    .asObservable()
                    .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
                    .disposed(by: self.disposeBag)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request a service
        viewModel.requestGetNewsFeedService()
            .asObservable()
            .subscribe(onNext: requestNewsFeedServiceDidSuccess())
            .disposed(by: disposeBag)
        
        // Table view
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
        // Configure cells and section title
        dataSource.configureCell = { (dataSource, tabelView, indexPath, student) in
            if let cell = tabelView.dequeueReusableCell(withIdentifier: "SampleTableViewCell", for: indexPath) as? SampleTableViewCell {
                cell.setContent(student)
                return cell
            }
            return UITableViewCell()
        }
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].subjectName
        }
    }

    @IBAction func addButtonDidPress(_ sender: AnyObject) {
        viewModel.requestGetNewsFeedService()
            .asObservable()
            .subscribe(onNext: requestNewsFeedServiceDidSuccess())
            .disposed(by: disposeBag)
    }

    @IBAction func deleteButtonDidPress(_ sender: AnyObject) {
        viewModel.requestDeleteNewsFeedService(at: 0)
            .asObservable()
            .subscribe(onNext: { result in
                if result {
                    var sections = self.dataSource.sectionModels
                    guard sections.count > 0  else { return }
                    let filteredItems = sections[0].items.enumerated().filter({ $0.offset != 0 }).map({ $0.element })
                    let mutatedSection = Subject(original: sections[0], items: filteredItems)
                    sections[0] = mutatedSection
                    
                    self.dataSource.setSections(sections)
                    self.tableView.reloadSections([0], with: .fade)
                } else {
                    print("Failed")
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
}

extension DataSourceViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
