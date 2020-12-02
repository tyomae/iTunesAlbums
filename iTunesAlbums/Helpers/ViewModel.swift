//
//  ViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

protocol ViewModel {
	associatedtype Action
	associatedtype State
	
	/// ViewModel can handle self state. e. g. dataUpdated or error
	var stateHandler: ((State) -> Void)? { get set }
	
	/// So that viewModel can get view model's user (e. g. ViewController) actions
	func process(action: Action)
}

enum ViewModelAction { }

extension ViewModel {
	 
	func process(action: ViewModelAction) { }
}
