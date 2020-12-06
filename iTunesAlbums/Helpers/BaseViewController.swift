//
//  BaseViewController.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import UIKit

class BaseViewController<V: ViewModel>: UIViewController {
	
	typealias ViewModelType = V
	
	var viewModel: ViewModelType!

	override func viewDidLoad() {
		self.setupViewModel()
		self.bindViewModelStateHandler()
		super.viewDidLoad()
	}

	// MARK: - Public API

	/// Override this method to setup ViewController's ViewModel
	func setupViewModel() { }
	
	/// Override this method to process ViewController's ViewModel states.
	/// - Parameter state: ViewModel state. e. g. dataLoaded
	func processViewModel(state: ViewModelType.State) { }
	
	// MARK: - Private logic
	
	private func bindViewModelStateHandler() {
		self.viewModel.stateHandler = { [weak self] state in
			self?.processViewModel(state: state)
		}
	}
}
