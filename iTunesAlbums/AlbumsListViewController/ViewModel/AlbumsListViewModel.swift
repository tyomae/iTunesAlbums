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
		case searchBarEmpty
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
		if searchText.isEmpty {
			self.cellViewModels.removeAll()
			self.stateHandler?(.searchBarEmpty)
//			self.stateHandler?(.dataLoaded)
			return
		}
		self.albumService.getAlbums(searchRequest: searchText) { [weak self] in
			guard let self = self else { return }
			switch $0 {
				case let .success(albums):
					self.searchingAlbums = self.sortAlbumsByAlphabet(albums: albums.results)
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
	
	private func sortAlbumsByAlphabet(albums: [Album]) -> [Album] {
		albums.sorted {
			return ($0.collectionName.localizedCaseInsensitiveCompare($1.collectionName) == .orderedAscending)
		}
	}
}
