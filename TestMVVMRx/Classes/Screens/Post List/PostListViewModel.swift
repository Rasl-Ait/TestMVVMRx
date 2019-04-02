//
//  ToDoViewModel.swift
//  TestMVVMRx
//
//  Created by rasl on 25/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import Foundation
import RealmSwift

class PostListViewModel: PostListViewModelType {
	private let realmService: RealmService = RealmServiceImplementation()
	private lazy var netService: NetworkingService = NetworkingServiceImplementation(with: network)

  private let network = NetworkProvider()
	
	init() {
		fetch()
	}
	
	func fetch() {
		netService.getPosts { [weak self] result in
			guard let `self` = self else { return }
			switch result {
			case .success(let items):
				items.forEach { item in
					self.realmService.addItem(item)
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	func resultsItems() -> Results<PostModel> {
		return realmService.fetchItems(ofType: PostModel.self)
	}
}

