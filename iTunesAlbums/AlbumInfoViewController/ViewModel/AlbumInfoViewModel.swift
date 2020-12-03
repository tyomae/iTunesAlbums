//
//  AlbumInfoViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import Foundation

final class AlbumInfoViewModelImpl: ViewModel {
	
	var stateHandler: ((State) -> Void)?
	
	enum State {
		case dataLoaded
	}
	
	init() {
		
	}
}
