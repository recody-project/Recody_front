//
//  EditGenreCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 2022/09/13.
//

import UIKit

class EditGenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var button: UIButton!

    func setData(with data: String) {
        button.setTitle(data, for: .normal)
        button.setTitle(data, for: .selected)
    }

    @IBAction func touchButton(_ sender: UIButton) {
        if button.state == .selected {
            button.borderColor = UIColor(hexString: "#CECECE")
            button.isSelected = false
        } else {
            button.borderColor = UIColor(hexString: "#51453D")
            button.isSelected = true
        }
    }
}
