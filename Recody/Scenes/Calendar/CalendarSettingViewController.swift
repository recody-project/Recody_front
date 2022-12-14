//
//  CalendarSettingViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/18.
//

import Foundation
import UIKit

class CalendarSettingViewController: CommonVC {
    var viewModel = CalendarSettingViewModel()
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbComplete: UILabel!
    @IBOutlet weak var btnCompleteDate: UIButton!
    @IBOutlet weak var btnRecordDate: UIButton!
    @IBOutlet weak var btnStartSunday: UIButton!
    @IBOutlet weak var btnStartMonday: UIButton!
    enum UseCase: Int, OrderType {
        case back = 100
        case complete = 101
        case flagCompleteDate = 102
        case flagRecordDate = 103
        case flagStartSunday = 104
        case flagStartMonday = 105
        var number: Int {
            return self.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    func setup() {
        btnBack.setTitle("", for: .normal)
        btnBack.tag = UseCase.back.rawValue
        lbComplete.tag = UseCase.complete.rawValue
        btnCompleteDate.tag = UseCase.flagCompleteDate.rawValue
        btnRecordDate.tag = UseCase.flagRecordDate.rawValue
        btnStartSunday.tag = UseCase.flagStartSunday.rawValue
        btnStartMonday.tag = UseCase.flagStartMonday.rawValue
        [ btnCompleteDate, btnRecordDate, btnStartSunday, btnStartMonday ].forEach({
            $0?.titleLabel?.font = UIFont.fontWithName(type: .medium, size: 14)
            $0?.layer.borderWidth = 1.0
            $0?.layer.cornerRadius = 8.0
        })
        [ btnBack, lbComplete, btnCompleteDate, btnRecordDate, btnStartSunday, btnStartMonday ].forEach({
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        })
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer ) {
        if let tag = sender.view?.tag {
            guard let useCase = UseCase(rawValue: tag) else { return }
            self.interactor?.just(useCase).drop()
        }
    }
    override func display(orderNumber: Int) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
            case .back:
                self.router?.popViewContoller(animated: true)
            case .complete:
            /* TODO
               saveAPi ?????? -> ?????? -> ?????? -> popViewController
                           -> ?????? -> ??????
             */
            break
            case .flagCompleteDate:
                viewModel.toggleCompletedDate()
            case .flagRecordDate:
                viewModel.toggleRecordedDate()
            case .flagStartSunday:
                viewModel.toggleStartSunday()
            case .flagStartMonday:
                viewModel.toggleStartMunday()
        }
        update()
    }
    func update() {
        let btns = [ btnStartSunday, btnStartMonday, btnRecordDate, btnCompleteDate ]
        let flags = [ viewModel.isStartSunday, viewModel.isStartMunday, viewModel.sortRecordedDate, viewModel.sortCompletedDate ]
        for (index,flag) in flags.enumerated() {
            let titleColor = flag ? UIColor(hexString: "#FFFFFF") : UIColor(hexString: "#999999")
            let backgroundColor = flag ? UIColor(hexString: "#373737") : UIColor(hexString: "#FFFFFF")
            let borderColor = flag ? UIColor(hexString: "#373737") : UIColor(hexString: "#E3E3E3")
//            btns[index]?.setTitleColor(titleColor, for: .normal)
            btns[index]?.titleLabel?.textColor = titleColor
            btns[index]?.backgroundColor = backgroundColor
            btns[index]?.layer.borderColor = borderColor.cgColor
        }
    }
}
class CalendarSettingViewModel {
    var isStartSunday = true
    var isStartMunday = false
    var sortCompletedDate = true
    var sortRecordedDate = false
    func toggleStartSunday() {
        isStartMunday = false
        isStartSunday = !isStartMunday
    }
    func toggleStartMunday() {
        isStartSunday = false
        isStartMunday = !isStartSunday
    }
    func toggleCompletedDate() {
        sortRecordedDate = false
        sortCompletedDate = !sortRecordedDate
    }
    func toggleRecordedDate() {
        sortCompletedDate = false
        sortRecordedDate = !sortCompletedDate
    }
}
