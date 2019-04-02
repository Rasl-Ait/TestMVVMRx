//
//  NetworkService.swift
//  TestMVVMRx
//
//  Created by rasl on 27/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

protocol NetworkingService {
	func getPosts(completion: @escaping ApiCompletionBlock<[Post]>)
}

class NetworkingServiceImplementation: NetworkingService {

	let baseUrl = "https://jsonplaceholder.typicode.com/posts"
	let network: Network
	
	init(with network: Network) {
		self.network = network
	}
	
	func getPosts(completion: @escaping ApiCompletionBlock<[Post]>) {
		guard let url = URL(string: baseUrl) else { return }
		network.request(with: url, type: [Post].self, method: .get) { (result) in
			completion(result)
		}
	}
}



