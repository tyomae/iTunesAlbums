//
//  ViewModel.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import Foundation

protocol ViewModel {
	
	/// View's action e. g. reload, delete(atIndex: IndexPath)
	associatedtype Action
	/// ViewModel's state e. g. dataLoaded
	associatedtype State
	
	/// ViewModel can handle self state. e. g. dataUpdated or error
	var stateHandler: ((State) -> Void)? { get set }
	
	/// So that viewModel can get view model's user (e. g. ViewController) actions
	func process(action: Action)
}

/// Default implementation of View's action
enum ViewModelAction { }

extension ViewModel {
	
	// Default implementation. View can not have any actions
	func process(action: ViewModelAction) { }
}
