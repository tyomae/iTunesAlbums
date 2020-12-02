//
//  AlbumsListViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

final class AlbumsListViewModelImpl: ViewModel {
	
	var stateHandler: ((State) -> Void)?
	
	enum State {
		case dataUpdated
	}
	
	enum Action {
		case searchTextDidChanged(text: String)
	}
	
	func process(action: Action) {
		switch action {
			case .searchTextDidChanged( _):
				return
		}
	}
}
