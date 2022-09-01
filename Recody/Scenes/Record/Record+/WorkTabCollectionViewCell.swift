//
//  WorkTabCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 2022/08/31.
//

import UIKit

class WorkTabCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var workListCollectionView: UICollectionView! {
        didSet {
            workListCollectionView.collectionViewLayout = createLayout()
            workListCollectionView.register(DropDownHeader.self, forSupplementaryViewOfKind: "header2", withReuseIdentifier: "dropDownHeader")
        }
    }

    let works: [Work] = [
        Work(id: "0", name: "Attention", image: "attention"),
        Work(id: "1", name: "1987", image: "1987"),
        Work(id: "2", name: "CallMeByYourName", image: "callMeByYourName"),
        Work(id: "3", name: "her", image: "her"),
        Work(id: "4", name: "Pink Venom", image: "pinkVenom"),
        Work(id: "5", name: "마더", image: "mother"),
        Work(id: "6", name: "블랙 팬서", image: "blackPanther"),
        Work(id: "7", name: "스파이더맨", image: "spiderman"),
        Work(id: "8", name: "After Like", image: "afterLike")
    ]

    func createLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(182))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(210)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 20
        section.contentInsets.trailing = 20
        section.contentInsets.bottom = 50
        let pagingheader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "header2", alignment: . topLeading)
        section.boundarySupplementaryItems = [
            pagingheader
        ]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
