//
//  FilterGenreCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 25.03.23.
//

import UIKit

class FilterGenreCollectionViewCell: UICollectionViewCell {
    static let id: String = "filterCategory"

    var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        button.setTitleColor(UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 0.953, green: 0.541, blue: 0.369, alpha: 1), for: .selected)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1).cgColor
        return button
    }()
    
    func setButton(name: String) {
        button.setTitle(name, for: .normal)
    }
    
    func toggleButton() {
        if button.isSelected {
            button.isSelected = false
        } else {
            button.isSelected = true
            button.backgroundColor = UIColor(red: 0.996, green: 0.953, blue: 0.937, alpha: 1).cgColor
            button.layer.borderColor = UIColor(red: 0.953, green: 0.541, blue: 0.369, alpha: 1).cgColor
        }
    }
}
