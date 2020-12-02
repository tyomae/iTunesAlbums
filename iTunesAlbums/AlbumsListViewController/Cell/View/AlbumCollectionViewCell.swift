//
//  AlbumCollectionViewCell.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import UIKit


class AlbumCollectionViewCell: UICollectionViewCell, ConfigurableView {

	@IBOutlet weak var albumImageView: UIImageView!
	@IBOutlet weak var albumTitleLabel: UILabel!
	@IBOutlet weak var artistLabel: UILabel!
	
	func configure(with model: AlbumCellViewModel) {
		
		albumTitleLabel.text  = model.albumTitle
		artistLabel.text  =  model.artistTitle
	}
}
