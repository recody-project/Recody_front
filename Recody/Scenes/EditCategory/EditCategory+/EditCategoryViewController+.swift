//
//  EditCategory+.swift
//  Recody
//
//  Created by 마경미 on 2022/09/05.
//

import Foundation
import UIKit

extension EditCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCategoryList.count+2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "editCategoryCollectionViewCell", for: indexPath) as? EditCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        if indexPath.row == 0 {
            cell.addAllView()
        } else if indexPath.row == 7 {
            cell.addAddView()
        } else {
            cell.setData(with: myCategoryList[indexPath.row - 1])
            addLongpressEvent(view: cell.view.categoryImage)
        }
        return cell
    }
}

extension EditCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 57, height: 81)
    }
}
