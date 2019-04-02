//
//  ResultNetworking.swift
//  TestMVVMRx
//
//  Created by rasl on 27/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case network
	case decoding
	case invalidReques
	
	var reason: String {
		switch self {
		case .network:
			return "An error occurred while fetching data "
		case .decoding:
			return "An error occurred while decoding data"
		case .invalidReques:
			return "Invalid Http Method"
		}
	}
}

extension HTTPURLResponse {
	var hasSuccessStatusCode: Bool {
		return 200...299 ~= statusCode
	}
}
