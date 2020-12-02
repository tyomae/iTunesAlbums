//
//  AlbumCellViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

protocol AlbumCellViewModel {
	var albumImageUrl: URL? { get }
	var albumTitle: String { get }
	var artistTitle: String { get }
}

final class AlbumCellViewModelImpl: AlbumCellViewModel {
	let albumImageUrl: URL?
	let albumTitle: String
	let artistTitle: String

	init(albumImageUrl: String, albumTitle: String, artistTitle: String) {
		let imageUrl = URL(string: albumImageUrl)
		self.albumImageUrl = imageUrl
		self.albumTitle = albumTitle
		self.artistTitle = artistTitle
	}
}
