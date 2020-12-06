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
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var noResultsLabel: UILabel!
	@IBOutlet weak var infoStackView: UIStackView!
	@IBOutlet weak var retryButton: UIButton! {
		didSet {
			self.retryButton.setTitle(R.string.localizable.retry(), for: .normal)
			self.retryButton.layer.cornerRadius = 8
			self.retryButton.layer.borderWidth = 1
			self.retryButton.layer.borderColor = UIColor.systemIndigo.cgColor
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = R.string.localizable.albums()
		
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
				self.infoStackView.isHidden = true
				self.collectionView.setContentOffset(.zero, animated: false)
				self.backgroundImage.isHidden = true
				self.noResultsLabel.isHidden = true
			case .error(let error):
				self.errorLabel.text = error
				self.infoStackView.isHidden  = false
				self.noResultsLabel.isHidden = true
				self.backgroundImage.isHidden = true
			case .searchTextEmpty:
				self.backgroundImage.isHidden = false
				self.infoStackView.isHidden = true
				self.noResultsLabel.isHidden = true
			case .noResults:
				self.infoStackView.isHidden = true
				self.backgroundImage.isHidden = true
				self.noResultsLabel.isHidden = false
				self.noResultsLabel.text = R.string.localizable.no_results()
		}
		self.collectionView.reloadData()
	}
	
	@IBAction func retryButtonTouched(_ sender: Any) {
		self.viewModel.getAlbums(searchText: searchController.searchBar.text ?? "")
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
			group.interItemSpacing = NSCollectionLayoutSpacing.fixed(16.0)
			let section = NSCollectionLayoutSection(group: group)
			section.interGroupSpacing = 16
			section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
			return section
		}
	}
	
	private func setupSearchBar() {
		self.searchController = UISearchController(searchResultsController: nil)
		self.searchController.searchResultsUpdater = self
		self.searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: R.string.localizable.search_albums(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemIndigo])
		self.searchController.obscuresBackgroundDuringPresentation = false
		self.navigationItem.hidesSearchBarWhenScrolling = false
		self.navigationItem.searchController = self.searchController
		
		self.definesPresentationContext = true
	}
	
	private func openAlbumInfoVC(with album: Album) {
		let vc = AlbumInfoViewController()
		let viewModel = AlbumInfoViewModelImpl(album: album)
		vc.viewModel = viewModel
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
	
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
	
	// MARK: - UISearchResultsUpdating
	
	func updateSearchResults(for searchController: UISearchController) {
		self.viewModel.process(action: .searchTextDidChanged(text: searchController.searchBar.text ?? ""))
	}
}
