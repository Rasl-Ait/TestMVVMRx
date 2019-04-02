//
//  ToDoItemViewModel.swift
//  TestMVVMRx
//
//  Created by rasl on 25/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import Foundation

protocol PostPresentable {
	var id: Int { get }
	var title: String { get }
	var body: String { get }
}

class Post: PostPresentable, Decodable {
	var id: Int
	var title: String
	var body: String
	
	init(id: Int, title: String, body: String) {
		self.title = title
		self.id = id
		self.body = body
	}
}
