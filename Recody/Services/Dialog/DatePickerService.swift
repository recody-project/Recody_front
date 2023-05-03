//
//  DatePickerService.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/25.
//

import Foundation
import UIKit
import SnapKit
protocol DatePickerServiceType {
    var context: UIViewController { get }
    init(_ context: UIViewController)
    func showDatePicker(selectDate: Date, completion: ((Date) -> Void)?)
}
class DatePickerService: DatePickerServiceType, DatePcikerViewDelegate {
    var context: UIViewController
    var completion: ((Date) -> Void)?
    required init(_ context: UIViewController) {
        self.context = context
    }
    func showDatePicker(selectDate: Date, completion: ((Date) -> Void)?) {
       let picker = DatePickerView()
        self.context.view.addSubview(picker)
        self.context.view.bringSubviewToFront(picker)
        picker.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        picker.delegate = self
        picker.setDate(selectDate: selectDate)
        self.completion = completion
    }
    func showDatePicker(selectDate: Date) {
        self.completion?(selectDate)
    }
    func complete(date: Date) {
        completion?(date)
    }
}
