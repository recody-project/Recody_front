//
//  WorkListCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 2022/08/30.
//

import UIKit

@IBDesignable
class WorkListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!

    func setData(with data: Work) {
        imageView.image = UIImage(named: data.image)
        nameLabel.text = data.name
    }

    func setMyReviewData(with data: Work) {
        imageView.image = UIImage(named: data.image)
        nameLabel.text = data.name
        ownerLabel.text = data.id
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
        guard let view = loadViewFromNib(nib: "WorkListCollectionViewCell") else {
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
