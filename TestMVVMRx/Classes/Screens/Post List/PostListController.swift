//
//  ViewController.swift
//  TestMVVMRx
//
//  Created by rasl on 25/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealmDataSources

class PostListController: UIViewController {
	@IBOutlet private weak var tableView: UITableView!
	
	var viewModel: PostListViewModelType = PostListViewModel()
	
	private let realmService: RealmService = RealmServiceImplementation()

	let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
		title = "Posts"
		registerCell()
		dataSource()
	}
	
	func toggleItem(_ item: PostModel) {
		item.toggleCompleted()
	}
	
	func registerCell() {
		tableView.register(
			PostTableCell.nib,
			forCellReuseIdentifier: PostTableCell.name
		)
	}
	
	func dataSource() {
		let dataSource = RxTableViewRealmDataSource<PostModel>(
		cellIdentifier: PostTableCell.name, cellType: PostTableCell.self) { cell, _, item in
			cell.model = item
			cell.onToggleCompleted = { [weak self] item in
				guard let `self` = self else { return }
				self.toggleItem(item)
			}
		}
		
		Observable
			.changeset(from: viewModel.resultsItems()) // Handle change form realm
			.bind(to: tableView.rx.realmChanges(dataSource)) // Bind data to tableView
			.disposed(by: disposeBag)
		
		tableView.rx.realmModelSelected(PostModel.self).subscribe(onNext: {
			Alert.showBasicAlert(self, title: "Body", message: $0.body.capitalized)
		}).disposed(by: disposeBag)
		
		tableView.rx.setDelegate(self)
			.disposed(by: disposeBag)
	}
}

// MARK: UITableViewDelegate

extension PostListController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return PostTableCell.height
	}
}
