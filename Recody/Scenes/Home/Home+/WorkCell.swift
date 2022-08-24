//
//  WorkCell.swift
//  Recody
//
//  Created by 마경미 on 2022/08/11.
//

import UIKit

class WorkCell: UICollectionViewCell {
    @IBOutlet weak var workImage: UIImageView!

    func setData(with data: Work) {
        workImage.image = UIImage(named: data.image)
    }
}
