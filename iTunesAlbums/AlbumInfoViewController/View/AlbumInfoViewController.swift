//
//  AlbumInfoViewController.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import UIKit

class AlbumInfoViewController: BaseViewController<AlbumInfoViewModelImpl> {
	
	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			self.collectionView.registerNibs(for: [AlbumInfoCollectionViewCell.self,
												   SongInfoCollectionViewCell.self,
												   AlbumCopyrightCollectionViewCell.self])
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	override func setupViewModel() {
		self.viewModel = AlbumInfoViewModelImpl()
	}
	
	override func processViewModel(state: AlbumInfoViewModelImpl.State) {
		switch state {
			case .dataLoaded:
				self.collectionView.reloadData()
		}
	}
}
