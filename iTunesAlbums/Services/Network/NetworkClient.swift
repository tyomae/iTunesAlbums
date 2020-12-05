//
//  NetworkClient.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

enum APIError: Error {
	case internalError
	case serverError
	case noInternet
	
	var stringError: String {
		switch self {
		case.serverError:
			return R.string.localizable.server_error()
		case.noInternet:
			return R.string.localizable.no_network_access()
		case.internalError:
			return R.string.localizable.internal_error()
		}
	}
}
