//
//  AlbumInfoViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import Foundation

final class AlbumInfoViewModelImpl: ViewModel {
	
	struct Section {
		enum SectionType {
			case albumInfo
			case track
			case copyright
		}
		
		let cellViewModels: [CellViewModel]
		let type: SectionType
	}
	
	var sections = [Section]()
	var stateHandler: ((State) -> Void)?
	private let albumService = AlbumServiceServiceImpl()
	private var album: Album
	private var songs = [Song]()
	private var songsCellViewModels = [SongInfoCellViewModelImpl]()
	
	enum State {
		case dataLoaded
		case error(errorString: String)
		case loading
	}
	
	enum Action {
		case viewDidLoad
	}
	
	init(album: Album) {
		self.album = album
		let albumInfoCellViewModel = AlbumInfoCellViewModelImpl(albumImageUrl: self.album.artworkUrl100,
																albumTitle: self.album.collectionName,
																artistTitle: self.album.artistName,
																albumGenre: self.album.primaryGenreName,
																dateRelease: self.album.releaseDate)
		self.sections.append(Section(cellViewModels: [albumInfoCellViewModel], type: .albumInfo))
	}
	
	func process(action: Action) {
		switch action {
			case .viewDidLoad:
				self.getSongs()
		}
	}
	
	private func getSongs() {
		self.stateHandler?(.loading)
		self.albumService.getAlbumSongs(albumId: self.album.collectionId) { [weak self] in
			guard let self = self else { return }
			switch $0 {
				case let .success(songs):
					self.songs = songs.results
					self.updateSongsViewModels()
					self.updateSections()
					if self.songs.isEmpty == false {
						self.stateHandler?(.dataLoaded)
					}
				case let .failure(error):
					self.stateHandler?(.error(errorString: error.stringError))
			}
		}
	}
	
	private func updateSongsViewModels() {
		self.songsCellViewModels.removeAll()
		for song in self.songs {
			if let songTitle = song.trackName,
			   let songNumber = song.trackNumber {
				self.songsCellViewModels.append(SongInfoCellViewModelImpl(songNumber: songNumber,
																		  songTitle: songTitle))
			}
		}
	}
	
	private func updateSections() {
		let albumCopyrightCellViewModel = AlbumCopyrightCellViewModelImpl(trackCount: self.album.trackCount,
																		  copyright: self.album.copyright ?? "")
		self.sections.append(Section(cellViewModels: songsCellViewModels, type: .track))
		self.sections.append(Section(cellViewModels: [albumCopyrightCellViewModel], type: .copyright))
	}
}
