//
//  RecordViewController+.swift
//  Recody
//
//  Created by 마경미 on 2022/08/30.
//

import Foundation
import UIKit

extension RecordViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == workTabCollectionView {
            return genre.count
        } else {
            return works.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == workTabCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workTabCollectionViewCell", for: indexPath)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workListCollectionViewCell", for: indexPath) as? WorkListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setData(with: works[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == workTabCollectionView {
            guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "tabHeader", for: indexPath) as? TabHeader else { return UICollectionReusableView() }
            headerview.setStackView(with: self.genre)
            headerview.setInitButton()
            return headerview
        } else {
            guard let headerview = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "dropDownHeader", for: indexPath) as? DropDownHeader else {
                return UICollectionReusableView()
            }
            return headerview
        }
    }
}
