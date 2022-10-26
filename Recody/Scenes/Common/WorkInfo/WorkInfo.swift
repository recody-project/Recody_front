//
//  WorkInfo.swift
//  Recody
//
//  Created by 마경미 on 23.09.22.
//

import UIKit

@IBDesignable
class WorkInfo: UIView {
    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var workGenre: UIButton!
    @IBOutlet weak var workName: UILabel!
    @IBOutlet weak var workReleaseDate: UILabel!
    @IBOutlet weak var workDirector: UILabel!
    @IBOutlet weak var workActors: UILabel!
    @IBOutlet weak var workRunningTime: UILabel!

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
        guard let view = loadViewFromNib(nib: "WorkInfo") else {
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
