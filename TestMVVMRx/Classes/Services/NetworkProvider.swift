//
//  GenericAPIClient.swift
//  TestMVVMRx
//
//  Created by rasl on 27/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

typealias ApiCompletionBlock<T : Decodable> = (Result<T>) -> Void

public enum RequestMethod: String {
	case get, post, put, patch
}

protocol Network {
	func request<T: Decodable> (
		with url: URL, type: T.Type, method:(RequestMethod), completion: @escaping ApiCompletionBlock<T>)
	
}

 final class NetworkProvider: Network {
	let disposeBag = DisposeBag()
	
	func request<T: Decodable> (
		with url: URL, type: T.Type, method:(RequestMethod), completion: @escaping ApiCompletionBlock<T>){
		
		guard let httpMethod = HTTPMethod(rawValue: method.rawValue.uppercased())
		   else {
					completion(Result.failure(NetworkError.invalidReques))
				return
		}
		RxAlamofire.requestData(httpMethod, url, parameters: nil, encoding: URLEncoding.default, headers: nil)
		.observeOn(MainScheduler.instance)
			.subscribe(onNext: { resp, data  in
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let response = try decoder.decode(T.self, from: data)
					completion(.success(response))
				} catch {
					completion(.failure(NetworkError.decoding))
				}
			}, onError: { error in
				completion(.failure(NetworkError.network))
			}).disposed(by: disposeBag)
		
	}
}


