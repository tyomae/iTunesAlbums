//
//  AlbumService.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

protocol AlbumService {
	func getAlbums(searchText: String, completion: @escaping((Result<AlbumsResult, APIError>) -> Void))
	func getCurrentAlbum(albumId: Int, completion: @escaping((Result<SongsResult, APIError>) -> Void))
}

class AlbumServiceServiceImpl: BaseNetworkService, AlbumService {
	
	private enum Endpoint {
		case currentAlbum(albumId: Int)
		case albumsList(searchText: String)
		
		var stringEndPoint: String {
			switch self {
				case .currentAlbum(let albumId):
					return "lookup/?id=\(albumId)&entity=song"
				case .albumsList(let searchText):
					return "search/media=music&entity=album&term=\(searchText)"
			}
		}
	}
	
	private var lastGetAlbumsRequest: URLSessionDataTask?
	
	func getAlbums(searchText: String, completion: @escaping((Result<AlbumsResult, APIError>) -> Void)) {
		guard let searchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
			return
		}
		// Сanceling the previous request to avoid unnecessary old responses
		self.lastGetAlbumsRequest?.cancel()
		self.lastGetAlbumsRequest = request(endpoint: Endpoint.albumsList(searchText: searchText).stringEndPoint, method: .GET, completion: completion)
	}
	
	func getCurrentAlbum(albumId: Int, completion: @escaping((Result<SongsResult, APIError>) -> Void)) {
		request(endpoint: Endpoint.currentAlbum(albumId: albumId).stringEndPoint, method: .GET, completion: completion)
	}
}
