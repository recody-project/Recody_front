//
//  TapHeader.swift
//  Recody
//
//  Created by 마경미 on 2022/09/01.
//

import UIKit

class TabHeader: UICollectionReusableView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var genreStackView: UIStackView!

    func setStackView(with genre: [String]) {
        for element in genre {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(element, for: .normal)
            button.setTitleColor(UIColor(hexString: "CECECE"), for: .normal)
            button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
            genreStackView.addArrangedSubview(button)
        }
        genreStackView.layoutIfNeeded()
    }

    func setInitButton() {
        guard let initButton = genreStackView.arrangedSubviews[0] as? UIButton else { return }
        print(initButton)
        initButton.setTitleColor(UIColor(hexString: "#51453D"), for: .normal)
        initButton.addBottomBorderWithColor(color: UIColor(hexString: "#51453D"), width: 1.0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
    }

    func xibSetup() {
        guard let view = loadViewFromNib(nib: "TabHeader") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib(nib: String) -> UICollectionReusableView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UICollectionReusableView
    }
}
