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
        } else if indexPath.row == myCategoryList.count + 1 {
            cell.addAddView()
        } else {
            cell.setData(with: myCategoryList[indexPath.row - 1])
            addLongpressEvent(view: cell.view)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > 0 && indexPath.row < myCategoryList.count + 1 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? EditCategoryCollectionViewCell else {
                return
            }
            if cell.view.returnIsBorder() {
                if countCheck >= 2 {
                    countCheck -= 1
                    cell.view.removeBorder()
                } else {
                    print("더 이상 뺄 수 없다.")
                }
            } else {
                if countCheck <= 3 {
                    countCheck += 1
                    cell.view.addBorder()
                } else {
                    print("더 이상 추가할 수 없다.")
                }
            }
        }
    }
}

extension EditCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 57, height: 81)
    }
}
