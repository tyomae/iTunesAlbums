//
//  AlbumCollectionViewCell.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import UIKit
import SDWebImage


class AlbumCollectionViewCell: UICollectionViewCell, ConfigurableView {

	@IBOutlet weak var albumImageView: UIImageView! {
		didSet {
			self.albumImageView.layer.cornerRadius = 4
			self.albumImageView.clipsToBounds = true
		}
	}
	@IBOutlet weak var albumTitleLabel: UILabel!
	@IBOutlet weak var artistLabel: UILabel!
	
	func configure(with model: AlbumCellViewModel) {
		self.albumImageView.sd_setImage(with: model.albumImageUrl, completed: nil)
		self.albumTitleLabel.text  = model.albumTitle
		self.artistLabel.text  =  model.artistTitle
	}
}
