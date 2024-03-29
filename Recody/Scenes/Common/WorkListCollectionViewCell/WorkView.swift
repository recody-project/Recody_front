//
//  WorkView.swift
//  Recody
//
//  Created by 마경미 on 03.03.23.
//

import UIKit

class WorkView: UIView {
    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var workName: UILabel!
    
    func setView(work: Work) {
        workImage.image = UIImage(named: work.image)
        workName.text = work.name
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
        guard let view = loadViewFromNib(nib: "WorkView") else {
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
