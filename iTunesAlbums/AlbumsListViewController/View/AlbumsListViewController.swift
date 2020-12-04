//
//  AlbumsListViewController.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import UIKit

class AlbumsListViewController: BaseViewController<AlbumsListViewModelImpl>, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {

	var searchController: UISearchController!
	
	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			self.collectionView.registerNib(for: AlbumCollectionViewCell.self)
		}
	}
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var errorLabel: UILabel! {
		didSet {
			self.errorLabel.isHidden = true
		}
	}
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Albums"
		
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
		
		self.collectionView.collectionViewLayout = createLayout()
		
		self.setupSearchBar()
    }
	
	override func setupViewModel() {
		self.viewModel = AlbumsListViewModelImpl()
	}
	
	override func processViewModel(state: AlbumsListViewModelImpl.State) {
		switch state {
			case .dataLoaded:
//				self.activityIndicator.stopAnimating()
				self.errorLabel.isHidden = true
				self.collectionView.isHidden = false
				self.collectionView.reloadData()
				self.backgroundImage.isHidden = true
			case .error(let error):
//				self.activityIndicator.startAnimating()
				self.errorLabel.text = error
				self.errorLabel.isHidden = false
				self.collectionView.isHidden = true
			case .searchBarEmpty:
//				self.activityIndicator.stopAnimating()
				self.errorLabel.isHidden = true
				self.collectionView.isHidden = true
				self.backgroundImage.isHidden = false
		}
	}
	
	private func createLayout() -> UICollectionViewCompositionalLayout {
		UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
			let estimatedHeight = CGFloat(130)
			let layoutSize = NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .estimated(estimatedHeight)
			)
			let item = NSCollectionLayoutItem(layoutSize: layoutSize)
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 3)
			group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 20, trailing: 20)
			group.interItemSpacing = NSCollectionLayoutSpacing.fixed(16.0)
			let section = NSCollectionLayoutSection(group: group)
			section.interGroupSpacing = 16
			section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
			return section
		}
	}
	
	private func setupSearchBar() {
		self.searchController = UISearchController(searchResultsController: nil)
		self.searchController.searchResultsUpdater = self
//		self.searchController.searchBar.placeholder = "Search albums"
		searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search album", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemIndigo])
		self.searchController.obscuresBackgroundDuringPresentation = false
		self.navigationItem.hidesSearchBarWhenScrolling = false
		self.navigationItem.searchController = searchController
//		self.navigationItem.backBarButtonItem?.title = R.string.localizable.countries()
		
		self.definesPresentationContext = true
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel.cellViewModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
		let cellViewModel = self.viewModel.cellViewModels[indexPath.item]
		cell.configure(with: cellViewModel)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let currentAlbum = self.viewModel.searchingAlbums[indexPath.item]
		self.openAlbumInfoVC(with: currentAlbum)
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		self.viewModel.process(action: .searchTextDidChanged(text: searchController.searchBar.text ?? ""))
	}
	
	private func openAlbumInfoVC(with album: Album) {
		let vc = AlbumInfoViewController()
		let viewModel = AlbumInfoViewModelImpl(album: album)
		vc.viewModel = viewModel
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
