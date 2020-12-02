//
//  AlbumCellViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

protocol AlbumCellViewModel {
	var albumImageUrl: String { get }
	var albumTitle: String { get }
	var artistTitle: String { get }
}

final class AlbumCellViewModelImpl: AlbumCellViewModel {
	let albumImageUrl: String
	let albumTitle: String
	let artistTitle: String

	init(albumImageUrl: String, albumTitle: String, artistTitle: String) {
		self.albumImageUrl = albumImageUrl
		self.albumTitle = albumTitle
		self.artistTitle = artistTitle
	}
}
