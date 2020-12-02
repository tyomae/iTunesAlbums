//
//  ConfigurableView.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

protocol ConfigurableView {
	
	associatedtype ConfigurationModel
	
	func configure(with model: ConfigurationModel)
}
