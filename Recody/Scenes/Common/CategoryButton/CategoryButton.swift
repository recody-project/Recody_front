//
//  CategoryButton.swift
//  Recody
//
//  Created by 마경미 on 28.11.22.
//

import UIKit

class CategoryButton: UIButton {
    var categories = ["영화":"#F38A5E","책":"#3EABB7","드라마":"#F6D266","음악":"#E77D82","공연":"#89AC5C"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setButton(with title: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let value = categories[title] {
            self.backgroundColor = UIColor(hexString: value)
        } else {
            self.backgroundColor = UIColor(hexString: "#666FC1")
        }
        self.setTitle(title, for: .normal)
        self.tintColor = .white
        layer.cornerRadius = 13
        isUserInteractionEnabled = false
        if title == "책" {
            self.widthAnchor.constraint(equalToConstant: 51).isActive = true
        } else if title == "드라마" {
            self.widthAnchor.constraint(equalToConstant: 72).isActive = true
        } else {
            self.widthAnchor.constraint(equalToConstant: 61).isActive = true
        }
        self.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
}
