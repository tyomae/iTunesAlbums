//
//  Album.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//
import Foundation

struct AlbumsResult: Decodable {
	let results: [Album]
	
	enum CodingKeys: String, CodingKey {
		case results = "results"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.results = try values.decode([Album].self, forKey: .results)
	}
}

struct Album: Decodable {
	let collectionName: String
	let artistName: String
	let artworkUrl100: String
	let collectionId: Int
	let copyright: String?
	let releaseDate: String
	let primaryGenreName: String
}
