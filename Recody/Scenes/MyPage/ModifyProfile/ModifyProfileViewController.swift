//
//  ModifyProfileViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/12/01.
//

import Foundation
import UIKit
protocol ModifyProfileViewControllerDelegate {
    func changeData(model:ModifyProfileViewModel)
}
class ModifyProfileViewController: UIViewController {
    let viewModel = ModifyProfileViewModel()
    var modal: HalfModalPresentationController?
    var delegate: ModifyProfileViewControllerDelegate?
    @IBOutlet weak var etNickName: UITextField!
    @IBOutlet weak var btnBack: UIButton!
//    @IBOutlet weak var btnCancel: UIButton!
//    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var lbGuide: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgProfileEdit: UIImageView! // 36 x 36
    enum UseCase: Int {
        case back = 100 // 뒤로가기
        case changeNickNameText = 101
        case changeProfileImage = 102
        case cancel = 103
        case update = 104
        var number: Int {
            return self.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    static func getInstanse() -> ModifyProfileViewController{
        guard let vc =  UIStoryboard(name: "ModifyProfile", bundle: nil).instantiateViewController(withIdentifier: "modifyProfile") as? ModifyProfileViewController
        else {
            fatalError()
        }
        return vc
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            guard let useCase = UseCase(rawValue: tag) else { return }
            switch useCase {
            case .back:
                self.modal?.dismissController()
//                self.dismiss(animated: true)
            case .update:
                self.modal?.dismissController({
                    self.delegate?.changeData(model: self.viewModel)
                })
            default:
            break
            }
        }
    }
    
    func setup() {
        if let subV = self.view.subviews.first {
            subV.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
        self.view.tag = UseCase.back.rawValue
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnBack.tag = UseCase.back.rawValue
//        btnCancel.tag = UseCase.cancel.rawValue
//        btnUpdate.tag = UseCase.update.rawValue
        imgProfileEdit.tag = UseCase.changeProfileImage.rawValue
        imgProfileEdit.isUserInteractionEnabled = true
        [btnBack, imgProfileEdit].forEach({
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        })
        imgProfileEdit.layer.cornerRadius = imgProfileEdit.frame.height / 2.0
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2.0
        imgProfile.layer.borderColor = UIColor.black.cgColor
        imgProfile.layer.borderWidth = 0.5
        etNickName.resignFirstResponder()
        etNickName.delegate = self
    }
    func update() {
        
    }
}
extension ModifyProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection  \(textField.text)")
    }
}
class ModifyProfileViewModel {
    var profileImg = "" // 프로필 이미지 url
    var newNickName = "" // 새로운 닉네임
}
