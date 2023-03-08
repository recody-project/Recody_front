//
//  WorkListView.swift
//  Recody
//
//  Created by 마경미 on 05.03.23.
//

import UIKit

class WorkListView: UIScrollView {

    @IBOutlet weak var workListStackView: UIStackView!
    
    func setView(work: [Work]) {
        for work in work {
            let workView = WorkView()
            workView.setView(work: work)
            workListStackView.addArrangedSubview(workView)
        }
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
        guard let view = loadViewFromNib(nib: "WorkListView") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib(nib: String) -> UIScrollView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIScrollView
    }
}
