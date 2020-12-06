//
//  BaseNetworkService.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation


class BaseNetworkService {
	
	// MARK:- Variables
	
	let baseURL = "https://itunes.apple.com/"
	
	enum Method: String {
		case GET
	}
	
	private let urlSession: URLSession
	
	init() {
		let config = URLSessionConfiguration.default
		config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
		config.urlCache = nil
		self.urlSession = URLSession(configuration: config)
	}
	
	// MARK:- Get Request Methods
	
	/// Request to given URL and convert to Decodable Object
	/// - Parameters:
	///   - endpoint: EndPoint for baseUrl
	///   - method: HTTP request method
	///   - completion: completion (Result, Error)
	/// - Returns: A URL session task that returns downloaded data directly to the app in memory.
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
	
	private func call<T: Decodable>(with request: URLRequest,
									completion: @escaping((Result<T, APIError>) -> Void)) -> URLSessionDataTask {
		let dataTask = self.urlSession.dataTask(with: request) { (data, response, error) in
			if let data = data, let object = try? JSONDecoder().decode(T.self, from: data) {
				DispatchQueue.main.async {
					completion(Result.success(object))
				}
			} else if let error = error as NSError? {
				let apiError: APIError
				if error.domain == NSURLErrorDomain, error.code == NSURLErrorNotConnectedToInternet {
					apiError = .noInternet
				} else if error.code == NSURLErrorCancelled {
					return
				} else {
					apiError = .serverError
				}
				DispatchQueue.main.async {
					completion(Result.failure(apiError))
				}
			}
		}
		dataTask.resume()
		return dataTask
	}
}
