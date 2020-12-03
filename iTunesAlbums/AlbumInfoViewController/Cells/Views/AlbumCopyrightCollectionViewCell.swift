//
//  AlbumCopyrightCollectionViewCell.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import UIKit

class AlbumCopyrightCollectionViewCell: UICollectionViewCell, ConfigurableView {
	@IBOutlet weak var songCountLabel: UILabel!
	@IBOutlet weak var copyrightLabel: UILabel!
	
	func configure(with model: AlbumCopyrightCellViewModel) {
		self.songCountLabel.text = model.songCount
		self.copyrightLabel.text = model.copyright
	}
}
