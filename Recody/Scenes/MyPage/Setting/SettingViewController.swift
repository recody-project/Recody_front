//
//  SettingViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/22.
//

import Foundation
import UIKit
import SnapKit

class SettingViewController: UIViewController {
    var viewModel = SettingViewModel()
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbAppVersion: UILabel!
    @IBOutlet weak var btnRecordySettingPageOpen: UIView!
    @IBOutlet weak var imgRecordySettingPageOpen: UIImageView!
    @IBOutlet weak var recordySettingPageHeight: NSLayoutConstraint!
    @IBOutlet weak var btnRecordFeedBackPageOpen: UIView!
    @IBOutlet weak var imgRecordFeedBackPageOpen: UIImageView!
    @IBOutlet weak var recordyFeedBackPageHeight: NSLayoutConstraint!
    @IBOutlet weak var btnSettingRecordy: UIView!
    @IBOutlet weak var btnOnlineBackup: UIView!
    @IBOutlet weak var btnAlarm: UIView!
    @IBOutlet weak var btnCalendar: UIView!
    @IBOutlet weak var btnFeedBack: UIView!
    @IBOutlet weak var btnGuide: UIView!
    @IBOutlet weak var btnStarAndReview: UIView!
    @IBOutlet weak var btnSendOpinion: UIView!
    @IBOutlet weak var btnTermsAndConditions: UIView!
    @IBOutlet weak var btnLogout:UIView!
    enum UseCase: Int{
        case back = 100 // 뒤로가기
        case onlineBackup = 101 // 온라인 백업
        case alarm = 102 // 알람 설정
        case calendar = 103 // 달력 설정
        case guide = 104 // 가이드
        case starAndReview = 105 // 별점 & 리뷰 주기
        case sendOpinion = 106 // 의견 보내기
        case termsAndConditions = 107 // 이용약관
        case feedBackPageOpen = 108
        case settingPageOpen = 109
        case logout = 200 // 로그아웃
        var number: Int {
            return self.rawValue
        }
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer){
        if let tag = sender.view?.tag {
            guard let useCase = UseCase(rawValue: tag) else{ return }
            switch useCase {
            case .settingPageOpen:
                viewModel.recodySettingEnable = !viewModel.recodySettingEnable
            case .feedBackPageOpen:
                viewModel.recodyFeedbackEnable = !viewModel.recodyFeedbackEnable
            case .back:
                self.navigationController?.popViewController(animated: true)
            case .calendar:
                self.navigationController?.pushViewController(CalendarSettingViewController.getInstanse(), animated: true)
            case .logout:
                ServiceProvider.shaerd.alertService(self).show(title: "알림", msg: "로그아웃 하시겠습니까?", actions: [UIAlertAction(title: "로그아웃", style: .destructive,handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }),UIAlertAction(title: "No", style: .default)])
            break
            default:
            break
            }
        }
        update()
    }
    static func getInstanse() -> SettingViewController{
        guard let vc = UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "setting") as? SettingViewController
        else {
            fatalError()
        }
        return vc
    }
    func setup() {
        let btns = [btnSettingRecordy,
                    btnOnlineBackup,
                    btnAlarm,
                    btnCalendar,
                    btnFeedBack,
                    btnGuide,
                    btnStarAndReview,
                    btnSendOpinion,
                    btnTermsAndConditions,
                    btnLogout]
        let actions =  [UseCase.settingPageOpen,
                        UseCase.onlineBackup,
                        UseCase.alarm,
                        UseCase.calendar,
                        UseCase.feedBackPageOpen,
                        UseCase.guide,
                        UseCase.starAndReview,
                        UseCase.sendOpinion,
                        UseCase.termsAndConditions,
                        UseCase.logout]
        for (index,btn) in btns.enumerated() {
            btn?.setTag(actions[index].rawValue)
            btn?.isUserInteractionEnabled = true
            btn?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        }
        btnBack.setTitle("", for: .normal)
        btnBack.tag = UseCase.back.rawValue
        btnBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        imgRecordySettingPageOpen.isUserInteractionEnabled = false
        imgRecordFeedBackPageOpen.isUserInteractionEnabled = false
        btnRecordySettingPageOpen.isUserInteractionEnabled = true
        btnRecordySettingPageOpen.tag = UseCase.settingPageOpen.rawValue
        btnRecordySettingPageOpen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnRecordFeedBackPageOpen.isUserInteractionEnabled = true
        btnRecordFeedBackPageOpen.tag = UseCase.feedBackPageOpen.rawValue
        btnRecordFeedBackPageOpen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
    }
    func update() {
        lbEmail.text = viewModel.emailAddress
        lbAppVersion.text = viewModel.appVersion
        self.imgRecordySettingPageOpen.image = viewModel.recodySettingEnable ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
        self.imgRecordFeedBackPageOpen.image = viewModel.recodyFeedbackEnable ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
        recordySettingPageHeight.constant = viewModel.recodySettingEnable ? 156 : 1
        btnOnlineBackup.isHidden = !viewModel.recodySettingEnable
        btnAlarm.isHidden = !viewModel.recodySettingEnable
        btnCalendar.isHidden = !viewModel.recodySettingEnable
        
        recordyFeedBackPageHeight.constant = viewModel.recodyFeedbackEnable ? 104 : 1
        btnSendOpinion.isHidden = !viewModel.recodyFeedbackEnable
        btnStarAndReview.isHidden = !viewModel.recodyFeedbackEnable
        
        var scrollHeight = 616.0
        if viewModel.recodySettingEnable { scrollHeight += 52.0 }
        if viewModel.recodyFeedbackEnable { scrollHeight += 52.0 }
        scrollViewHeight.constant = scrollHeight
        self.view.layoutIfNeeded()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
}
extension UIView {
    func setTag(_ tag: Int) {
        self.tag = tag
    }
}
struct SettingViewModel {
    var recodySettingEnable = false
    var recodyFeedbackEnable = false
    var appVersion = "1.0.1"
    var emailAddress = "ikmujn5@naver.com"
}
