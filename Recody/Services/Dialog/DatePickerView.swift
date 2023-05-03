//
//  DatePcikerView.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/25.
//

import Foundation
import UIKit

class DatePickerView: UIView {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnDone: UILabel!
    var selectDate : Date!
    var delegate: DatePcikerViewDelegate?
    var animating = false
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         self.loadXib()
     }
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         self.loadXib()
     }
    private func loadXib() {
        let identifier = String(describing: type(of: self))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        self.addSubview(customView)
        self.datePicker.setValue(UIColor.black, forKey: "textColor")
        self.datePicker.setValue(false, forKey: "highlightsToday")
        self.datePicker.timeZone = .current
        self.btnDone.isUserInteractionEnabled = true
        self.btnDone.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.doneAction)))
        self.backgroundColor = .black.withAlphaComponent(0.5)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismiss)))
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
    }
    @objc func dismiss() {
        if !animating {
            self.animating = true
            UIView.animate(withDuration: 0.1, delay: 0.0, animations: {
                self.alpha = 0.0
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }
    }
    func setDate(selectDate: Date) {
        self.selectDate = selectDate
        self.datePicker.date = selectDate
    }
    
    @objc func doneAction() {
        if !animating {
            self.animating = true
            UIView.animate(withDuration: 0.1, delay: 0.0, animations: {
                self.alpha = 0.0
            }, completion: { _ in
                self.delegate?.complete(date: self.selectDate)
                self.removeFromSuperview()
            })
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        if let picker = sender as? UIDatePicker {
                                self.selectDate = picker.date
        }
        
    }
}
protocol DatePcikerViewDelegate {
    func complete(date: Date)
}
