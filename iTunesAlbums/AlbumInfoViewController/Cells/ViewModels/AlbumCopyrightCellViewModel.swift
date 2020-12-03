//
//  AlbumCopyrightCellViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import Foundation

protocol AlbumCopyrightCellViewModel {
	var songCount: String { get }
	var copyright: String { get }
}

final class AlbumCopyrightCellViewModelImpl: AlbumCopyrightCellViewModel {
	let songCount: String
	let copyright: String

	init(trackCount: Int, copyright: String){
		self.songCount = String(trackCount)
		self.copyright = copyright
	}
}
