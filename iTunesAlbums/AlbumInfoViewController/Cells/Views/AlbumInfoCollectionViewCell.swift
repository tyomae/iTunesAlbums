//
//  AlbumInfoCollectionViewCell.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import UIKit
import SDWebImage

class AlbumInfoCollectionViewCell: UICollectionViewCell, ConfigurableView {
	@IBOutlet weak var albumTitleLabel: UILabel!
	@IBOutlet weak var albumImageView: UIImageView!
	@IBOutlet weak var artistName: UILabel!
	@IBOutlet weak var albumGenreLabel: UILabel!
	@IBOutlet weak var dateReleaseLabel: UILabel!
	
	func configure(with model: AlbumInfoCellViewModel) {
		self.albumTitleLabel.text = model.albumTitle
		self.albumImageView.sd_setImage(with: model.albumImageUrl, completed: nil)
		self.artistName.text = model.albumTitle
		self.albumGenreLabel.text = model.albumGenre
		self.dateReleaseLabel.text = model.dateRelease
	}
}
