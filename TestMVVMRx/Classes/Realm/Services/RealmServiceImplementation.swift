//
//  RealmServiceImplementation.swift
//  TestMVVMRx
//
//  Created by rasl on 26/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmService {
	
	// Method ToDoITem
	func addItem(_ model: Post)
	func fetchItems<T: Object>(ofType type: T.Type) ->  Results<T>
	func save(_ object: Object)
}

class RealmServiceImplementation: RealmService {
	fileprivate lazy var realm = try!
		Realm(configuration: .defaultConfiguration)
	
	func addItem(_ model: Post) {
		let predicate = NSPredicate(format: "id = %ld", model.id)
		let isEmpty = realm.objects(PostModel.self).filter(predicate).isEmpty
		if !isEmpty { return }
		
		let object = PostModel()
		object.id = model.id
		object.title = model.title
		object.body = model.body
		save(object)
	}
	
	func fetchItems<T>(ofType type: T.Type) -> Results<T> where T : Object {
		let byKeyPath = PostModel.Property.isCompleted.rawValue
		return realm.objects(T.self).sorted(byKeyPath: byKeyPath)
	}
	
	// Method General
	func save(_ object: Object) {
		do {
			try realm.write {
				realm.add(object, update: true)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
}
