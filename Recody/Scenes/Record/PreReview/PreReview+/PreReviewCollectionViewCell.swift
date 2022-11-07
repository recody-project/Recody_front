//
//  PreReviewCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 11.10.22.
//

import UIKit

@IBDesignable
class PreReviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    func setData(with data: PreReview.PreReview) {
        numberLabel.text = "\(data.recordCount)"
        dateLabel.text = "\(data.date)"
        contentLabel.text = "\(data.note)"
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
        guard let view = loadViewFromNib(nib: "PreReviewCollectionViewCell") else {
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
