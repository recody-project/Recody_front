//
//  WorkListCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 2022/08/30.
//

import UIKit

class WorkListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var owner: UILabel!

    func setData(with data: Work) {
        imageView.image = UIImage(named: data.image)
        name.text = data.name
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
