//
//  AlbumsListViewController.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import UIKit

class AlbumsListViewController:  BaseViewController<AlbumsListViewModelImpl>, UICollectionViewDelegate, UICollectionViewDataSource {
	
	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			self.collectionView.registerNib(for: AlbumCollectionViewCell.self)
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
    }
	
	override func processViewModel(state: AlbumsListViewModelImpl.State) {
		switch state {
			case .dataUpdated:
				self.collectionView.reloadData()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}
}
