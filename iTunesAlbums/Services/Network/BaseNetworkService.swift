//
//  BaseNetworkService.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

class BaseNetworkService {
	
	let baseURL = "https://itunes.apple.com/"
	
	enum Method: String {
		case GET
	}
	private let urlSession: URLSession
	
		init() {
			let config = URLSessionConfiguration.default
			config.requestCachePolicy = .reloadIgnoringLocalCacheData
			config.urlCache = nil
			self.urlSession = URLSession(configuration: config)
		}
	
	
	@discardableResult
	func request<T: Decodable>(endpoint: String,
							   method: Method,
							   completion: @escaping((Result<T, APIError>) -> Void)) -> URLSessionDataTask? {
		let path = "\(baseURL)\(endpoint)"
		guard let url = URL(string: path)
			else { completion(.failure(.internalError)); return nil }
		
		var request = URLRequest(url: url)
		request.httpMethod = "\(method)"
		
		return call(with: request, completion: completion)
	}
	
	@discardableResult
	func call<T: Decodable>(with request: URLRequest,
							completion: @escaping((Result<T, APIError>) -> Void)) -> URLSessionDataTask {
		let dataTask = self.urlSession.dataTask(with: request) { (data, response, error) in
			if let data = data, let object = try? JSONDecoder().decode(T.self, from: data) {
				DispatchQueue.main.async {
					completion(Result.success(object))
				}
			} else if let error = error as NSError?, error.domain == NSURLErrorDomain, error.code == NSURLErrorNotConnectedToInternet {
				DispatchQueue.main.async {
					completion(Result.failure(.noInternet))
				}
			} else {
				DispatchQueue.main.async {
					completion(Result.failure(.serverError))
				}
			}
			
		}
		dataTask.resume()
		return dataTask
	}
}
