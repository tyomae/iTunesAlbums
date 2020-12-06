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
	private var albumService = AlbumServiceServiceImpl()
	
	enum State {
		case dataLoaded
		case error(errorString: String)
		case searchTextEmpty
		case noResults
	}
	
	enum Action {
		case searchTextDidChanged(text: String)
	}
	
	init() {
		self.getAlbums(searchText: "")
	}
	
	func process(action: Action) {
		switch action {
			case .searchTextDidChanged(let text):
				self.getAlbums(searchText: text)
		}
	}
	
	private func updateCellViewModels() {
		self.cellViewModels.removeAll()
		for album in searchingAlbums {
			let cellViewModel = AlbumCellViewModelImpl(albumImageUrl: album.artworkUrl100,
													   albumTitle: album.collectionName,
													   artistTitle: album.artistName)
			self.cellViewModels.append(cellViewModel)
		}
	}
	
	func getAlbums(searchText: String) {
		if searchText.isEmpty {
			self.cellViewModels.removeAll()
			self.stateHandler?(.searchTextEmpty)
			return
		}
		self.albumService.getAlbums(searchText: searchText) { [weak self] in
			guard let self = self else { return }
			switch $0 {
				case let .success(albums):
					self.processAlbums(albums: albums.results)
				case let .failure(error):
					self.stateHandler?(.error(errorString: error.stringError))
			}
		}
	}
	
	private func processAlbums(albums: [Album]) {
		if albums.isEmpty {
			self.searchingAlbums.removeAll()
			self.updateCellViewModels()
			self.stateHandler?(.noResults)
		} else {
			// Sorting by Albums title
			self.searchingAlbums = albums.sorted {
				return ($0.collectionName.localizedCaseInsensitiveCompare($1.collectionName) == .orderedAscending)
			}
			self.updateCellViewModels()
			self.stateHandler?(.dataLoaded)
		}
	
	}
}
