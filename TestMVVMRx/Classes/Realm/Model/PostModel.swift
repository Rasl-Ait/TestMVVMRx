//
//  ToDoItem.swift
//  TestMVVMRx
//
//  Created by rasl on 26/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PostModel: Object {
	enum Property: String {
		case id, text, body, isCompleted
	}
	
	dynamic var id: Int = 0
	dynamic var title: String = ""
	dynamic var body: String = ""
	dynamic var createAt: Date = Date()
	dynamic var isCompleted = false
	
	override static func primaryKey() -> String? {
		return PostModel.Property.id.rawValue
	}
	
	func toggleCompleted() {
		guard let realm = realm else { return }
		try! realm.write {
			isCompleted = !isCompleted
		}
	}
}
