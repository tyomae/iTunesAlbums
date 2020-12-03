//
//  AlbumService.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

protocol AlbumService {
	func getAlbums(searchRequest: String, completion: @escaping((Result<AlbumsResult, APIError>) -> Void))
	//	func getCurrentAlbum(currentId: Int, completion: @escaping((Result<Album, APIError>) -> Void))
}

class AlbumServiceServiceImpl: BaseNetworkService, AlbumService {
	
	private enum Endpoint {
		case currentAlbum(albumId: Int)
		case albumsList(searchRequest: String)
		
		var stringEndPoint: String {
			switch self {
				case .currentAlbum(let albumId):
					return "lookup/?id=\(albumId)&entity=song"
				case .albumsList(let searchRequest):
					return "search/media=music&entity=album&term=\(searchRequest)"
			}
		}
	}
	
	func getAlbums(searchRequest: String, completion: @escaping((Result<AlbumsResult, APIError>) -> Void)) {
			let searchRequestWitoutSpace = searchRequest.replacingOccurrences(of: " ", with: "")
			request(endpoint: Endpoint.albumsList(searchRequest: searchRequestWitoutSpace).stringEndPoint, method: .GET, completion: completion)
	}
	
	//	func getCurrentAlbum(currentId: Int, completion: @escaping((Result<Album, APIError>) -> Void)) {
	//		request(endpoint: Endpoint.currentAlbum(albumId: currentId).stringEndPoint, method: .GET, completion: completion)
	//	}
}
