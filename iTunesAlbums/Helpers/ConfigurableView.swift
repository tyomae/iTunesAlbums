//
//  ConfigurableView.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

/// A type that can configured with ConfigurationModel.
/// Using with custom views for separation data logic and view logic
protocol ConfigurableView {
	
	associatedtype ConfigurationModel
	
	func configure(with model: ConfigurationModel)
}
