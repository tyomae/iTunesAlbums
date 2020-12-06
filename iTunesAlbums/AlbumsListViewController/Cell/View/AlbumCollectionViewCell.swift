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
			self.albumImageView.layer.cornerRadius = 6
			self.albumImageView.clipsToBounds = true
		}
	}
	@IBOutlet weak var albumTitleLabel: UILabel!
	@IBOutlet weak var artistLabel: UILabel!
	
	func configure(with model: AlbumCellViewModel) {
		albumImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
		albumImageView.sd_setImage(with: model.albumImageUrl) { [weak self] (image, _, _, _) in
			if image == nil {
				self?.albumImageView.image = #imageLiteral(resourceName: "noPhoto")
			}
		}
		
		self.albumTitleLabel.text = model.albumTitle
		self.artistLabel.text = model.artistTitle
	}
}
