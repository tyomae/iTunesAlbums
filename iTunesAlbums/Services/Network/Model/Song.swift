//
//  Song.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import Foundation

struct SongsResult: Decodable {
	var results: [Song]
	
	enum CodingKeys: String, CodingKey {
		case results = "results"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.results = try values.decode([Song].self, forKey: .results)
	}
}

struct Song: Decodable {
	let trackName: String?
	let trackNumber: Int?
}
