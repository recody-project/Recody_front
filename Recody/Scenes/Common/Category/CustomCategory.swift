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

    var isBorder = false

    func setData(with data: Category) {
        categoryImage.image = UIImage(named: data.image)
        categoryName.text = data.name
    }

    func setDataForAdd() {
        categoryImage.image = UIImage(named: "plus")
        categoryImage.contentMode = .center
        categoryName.text = "추가하기"
    }

    func addBorder() {
        categoryImage.layer.borderWidth = 1.0
        categoryImage.layer.borderColor = UIColor(hexString: "#51453D").cgColor
        isBorder = true
    }

    func removeBorder() {
        categoryImage.layer.borderWidth = 0
        isBorder = false
    }

    func returnIsBorder() -> Bool {
        return isBorder
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
