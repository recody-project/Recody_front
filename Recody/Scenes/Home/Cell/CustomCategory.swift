//
//  CustomCategory.swift
//  Recody
//
//  Created by 마경미 on 2022/08/12.
//

import UIKit

@IBDesignable
class CustomCategory: UIView {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    var tapGesture: UITapGestureRecognizer!

    func setData(with data: Category) {
        categoryImage.image = UIImage(named: data.image)
        categoryName.text = data.name
        categoryImage.isUserInteractionEnabled = true
        categoryImage.addGestureRecognizer(tapGesture)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        xibSetup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        xibSetup()
    }

    func commonInit() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
    }

    @objc func touchToPickPhoto() {
        print("hi")
    }

    func xibSetup() {
        guard let view = loadViewFromNib(nib: "CustomCategory") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
