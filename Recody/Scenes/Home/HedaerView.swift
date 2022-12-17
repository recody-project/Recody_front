//
//  HedaerView.swift
//  Recody
//
//  Created by 마경미 on 30.11.22.
//

import UIKit

class HedaerView: UICollectionReusableView {
    var categories = ["영화", "책", "드라마", "음악", "공연"]

    var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    func setStackView() {
//        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
//        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        for value in categories {
            let button = CategoryButton()
            button.setButton(with: value)
            stackView.addArrangedSubview(button)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        setStackView()
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        setStackView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
