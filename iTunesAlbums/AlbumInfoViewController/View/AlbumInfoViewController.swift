//
//  AlbumInfoViewController.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 03.12.2020.
//

import UIKit

class AlbumInfoViewController: BaseViewController<AlbumInfoViewModelImpl>, UICollectionViewDelegate, UICollectionViewDataSource {
	
	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			self.collectionView.registerNibs(for: [AlbumInfoCollectionViewCell.self,
												   SongInfoCollectionViewCell.self,
												   AlbumCopyrightCollectionViewCell.self])
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.collectionView.collectionViewLayout = createLayout()
		
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
	}
	
	override func processViewModel(state: AlbumInfoViewModelImpl.State) {
		switch state {
			case .dataLoaded:
				self.collectionView.reloadData()
			case .error(let error):
				print(error)
//				self.activityIndicator.stopAnimating()
//				self.retryButton.isHidden = false
//				self.errorLabel.text = error
//				self.errorLabel.isHidden = false
				self.collectionView.isHidden = true
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return self.viewModel.sections.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel.sections[section].cellViewModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cellViewModel = self.viewModel.sections[indexPath.section].cellViewModels[indexPath.item]
		if let cellModel = cellViewModel as? AlbumInfoCellViewModelImpl {
			let cell: AlbumInfoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
			cell.configure(with: cellModel)
			return cell
		} else if let cellModel = cellViewModel as? SongInfoCellViewModelImpl {
			let cell: SongInfoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
			cell.configure(with: cellModel)
			return cell
		} else if let cellModel = cellViewModel as? AlbumCopyrightCellViewModelImpl {
			let cell: AlbumCopyrightCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
			cell.configure(with: cellModel)
			return cell
		}
		fatalError("Unknowned cellViewModel")
	}
	
	private func createLayout() -> UICollectionViewCompositionalLayout {
		UICollectionViewCompositionalLayout { (section, environment) ->
			NSCollectionLayoutSection? in
			var estimatedHeight: CGFloat
			switch self.viewModel.sections[section].type {
				case .albumInfo:
					estimatedHeight = CGFloat(150)
				case .track:
					estimatedHeight = CGFloat(33)
				case .copyright:
					estimatedHeight = CGFloat(60)
			}
			let layoutSize = NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .absolute(estimatedHeight)
			)
			let item = NSCollectionLayoutItem(layoutSize: layoutSize)
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
			group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
			let section = NSCollectionLayoutSection(group: group)
			section.interGroupSpacing = 10
			section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)

			return section
		}
	}
}
