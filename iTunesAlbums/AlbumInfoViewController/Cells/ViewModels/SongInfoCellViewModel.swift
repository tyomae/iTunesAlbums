//
//  SongInfoCellViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import Foundation

protocol SongInfoCellViewModel: CellViewModel {
	var songCount: String { get }
	var songTitle: String { get }
}

final class SongInfoCellViewModelImpl: SongInfoCellViewModel {
	
	let songCount: String
	let songTitle: String

	init(songNumber: Int, songTitle: String){
		self.songCount = String(songNumber)
		self.songTitle = songTitle
	}
}
