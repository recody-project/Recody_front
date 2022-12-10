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
        if let value = categories[title] {
            self.titleLabel?.text = title
            self.backgroundColor = UIColor(hexString: value)
        } else {
            self.titleLabel?.text = "사용자화"
            self.backgroundColor = UIColor(hexString: "#666FC1")
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
}
