//
//  EditGenreViewController+.swift
//  Recody
//
//  Created by 마경미 on 2022/09/13.
//

import Foundation
import UIKit

extension EditGenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "editGenreCollectionViewCell", for: indexPath) as? EditGenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(with: genres[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let itemsPerRow: CGFloat = 2
        let cellWidth = (width) / itemsPerRow
        return CGSize(width: cellWidth - 10, height: 46)
    }
}
