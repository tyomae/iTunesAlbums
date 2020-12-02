//
//  UICollectionView+registerCell.swift
//  iTunesAlbums
//
//  Created by Артем  Емельянов  on 02.12.2020.
//

import UIKit

extension UICollectionView {
	
	func registerNib<T: UICollectionViewCell>(for cellClass: T.Type) {
		register(T.nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func registerNibs(for cellClasses: [UICollectionViewCell.Type]) {
		cellClasses.forEach { register($0.nib, forCellWithReuseIdentifier: $0.defaultReuseIdentifier) }
	}
	
	func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}
		return cell
	}
}

protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

protocol NibLoadableView: class {
	static var nib: UINib { get }
}

extension ReusableView where Self: UIView {
	static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}
extension NibLoadableView where Self: UIView {
	static var nib: UINib {
		let nibName = String(describing: self)
		return UINib(nibName: nibName, bundle: nil)
	}
}

extension UICollectionViewCell: ReusableView, NibLoadableView {
	
}
