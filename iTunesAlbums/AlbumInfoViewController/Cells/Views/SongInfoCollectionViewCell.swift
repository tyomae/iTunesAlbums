//
//  SongInfoCollectionViewCell.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import UIKit

class SongInfoCollectionViewCell: UICollectionViewCell, ConfigurableView {
	@IBOutlet weak var songNumberLabel: UILabel!
	@IBOutlet weak var songTitleLabel: UILabel!
	
	func configure(with model: SongInfoCellViewModel) {
		self.songNumberLabel.text = model.songCount
		self.songTitleLabel.text = model.songTitle
	}
}
