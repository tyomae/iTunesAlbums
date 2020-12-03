//
//  AlbumsListViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

final class AlbumsListViewModelImpl: ViewModel {
	
	var stateHandler: ((State) -> Void)?
	var searchingAlbums = [Album]()
	var cellViewModels = [AlbumCellViewModel]()
	var albumService = AlbumServiceServiceImpl()
	
	enum State {
		case dataLoaded
		case error(errorString: String)
	}
	
	enum Action {
		case searchTextDidChanged(text: String)
	}
	
	init() {
		self.updateCellViewModels()
	}
	
	private func updateCellViewModels() {
		self.cellViewModels.removeAll()
		for album in searchingAlbums {
			let cellViewModel = AlbumCellViewModelImpl(albumImageUrl: album.artworkUrl100,
													   albumTitle: album.collectionName,
													   artistTitle: album.artistName)
			self.cellViewModels.append(cellViewModel)
		}
		self.stateHandler?(.dataLoaded)
	}
	
	private func getAlbums(searchText: String) {
		//		self.stateHandler?(.loading)
		if searchText.isEmpty {
			return
		}
		self.albumService.getAlbums(searchRequest: searchText) { [weak self] in
			guard let self = self else { return }
			switch $0 {
				case let .success(albums):
					self.searchingAlbums = albums.results
				case let .failure(error):
					self.stateHandler?(.error(errorString: error.stringError))
			}
		}
		self.updateCellViewModels()
	}
	
	func process(action: Action) {
		switch action {
			case .searchTextDidChanged(let text):
				self.getAlbums(searchText: text)
		}
	}
}
