//
//  AlbumInfoCellViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import Foundation

protocol AlbumInfoCellViewModel: CellViewModel {
	var albumImageUrl: URL? { get }
	var albumTitle: String { get }
	var artistName: String { get }
	var albumGenre: String { get }
	var dateRelease: String { get }
}

final class AlbumInfoCellViewModelImpl: AlbumInfoCellViewModel {
	
	let albumImageUrl: URL?
	let albumTitle: String
	let artistName: String
	let albumGenre: String
	let dateRelease: String

	init(albumImageUrl: String,
		 albumTitle: String,
		 artistTitle: String,
		 albumGenre: String,
		 dateRelease: String)
	{
		let imageUrl = URL(string: albumImageUrl)
		self.albumImageUrl = imageUrl
		self.albumTitle = albumTitle
		self.artistName = artistTitle
		self.albumGenre = albumGenre.uppercased()
		self.dateRelease = String(dateRelease.prefix(4)) //get only release year
	}
}
