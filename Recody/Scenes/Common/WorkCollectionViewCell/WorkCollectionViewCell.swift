//
//  WorkCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 2022/08/23.
//

import UIKit

@IBDesignable
class WorkCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var workImage: UIImageView!

    func setData(with data: Work) {
        workImage.image = UIImage(named: data.image)
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
        guard let view = loadViewFromNib(nib: "WorkCollectionViewCell") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib(nib: String) -> UICollectionViewCell? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UICollectionViewCell
    }
}
