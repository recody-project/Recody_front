//
//  EditCategoryCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 2022/09/05.
//

import UIKit

class EditCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view: CustomCategory!

    func addAllView() {
        view.setData(with: Category(name: "전체", image: "book"))
        view.addBorder()
    }

    func addAddView() {
        view.setDataForAdd()
    }

    func setData(with data: Category) {
        view.setData(with: data)
    }
    
    func addBorder() {
        view.addBorder()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
