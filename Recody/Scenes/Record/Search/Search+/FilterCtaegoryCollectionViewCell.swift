//
//  FilterCtaegoryCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 25.03.23.
//

import UIKit

class FilterCtaegoryCollectionViewCell: UICollectionViewCell {
    static let id: String = "filterCategory"

    var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        button.setTitleColor(UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
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
        }
    }
}
