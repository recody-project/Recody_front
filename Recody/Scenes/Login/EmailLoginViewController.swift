//
//  EmailLoginViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/05.
//

import Foundation
import UIKit
class EmailLoginViewController: UIViewController {
    let viewModel = EmailLoginViewModel()
    
    enum UseCase: Int,OrderType {
        case loginAction = 1
        case findIdAction = 2
        case findPwAction = 3
        case registerMemberAction = 4
        case inputEmailShow = 5
        case inputPwShow = 6
        case togglePassword = 7
        var number: Int {
            return self.rawValue
        }
    }

    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwPw: UIView!
    @IBOutlet weak var imgPwHidden: UIImageView!
    @IBOutlet weak var inputEmail: UITextField! // tag = 0
    @IBOutlet weak var helpEmail: UILabel! //
    @IBOutlet weak var helpPw: UILabel! //
    
    @IBOutlet weak var inputPw: UITextField! // tag = 1
    @IBOutlet weak var inputEmailTitlePosition: NSLayoutConstraint! // disable 30 enable 12
    @IBOutlet weak var inputPwTitlePosition: NSLayoutConstraint! // disable 30 enable 12
    
    @IBOutlet weak var btnLogin: UIView!
    @IBOutlet weak var btnFindId: UILabel!
    @IBOutlet weak var btnFindPw: UILabel!
    @IBOutlet weak var btnRegisterMember: UIView!
    
    @IBAction func backAction(_ sender: Any) {
//        self.router?.popViewContoller(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    static func getInstanse() -> EmailLoginViewController{
        guard let vc = UIStoryboard(name: "EmailLogin", bundle: nil).instantiateInitialViewController() as? EmailLoginViewController
        else {
            fatalError()
        }
        return vc
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag,
              let useCase = UseCase(rawValue: tag) else { return }
        switch useCase {
        case .loginAction:
            self.navigationController?.pushViewController(TabBarController.getInstanse(), animated: true)
//        case .findIdAction:
//        case .findPwAction:
        case .registerMemberAction:
            self.navigationController?.pushViewController(RegisterMemberViewController.getInstanse(), animated: true)
        case .inputEmailShow:
            viewModel.showEmailText = true
            inputEmail.becomeFirstResponder()
        case .inputPwShow:
            viewModel.showPwText = true
            inputPw.becomeFirstResponder()
        case .togglePassword:
            viewModel.passwordHidden = !viewModel.passwordHidden
        default:
        break
//            self.presenter?.alertService.showToast("\(useCase)")
        }
        update()
    }
    func setup() {
        btnLogin.tag = UseCase.loginAction.rawValue
        btnFindId.tag = UseCase.findIdAction.rawValue
        btnFindPw.tag = UseCase.findPwAction.rawValue
        vwEmail.tag = UseCase.inputEmailShow.rawValue
        vwPw.tag = UseCase.inputPwShow.rawValue
        imgPwHidden.tag = UseCase.togglePassword.rawValue
        
        btnRegisterMember.tag = UseCase.registerMemberAction.rawValue
        [btnLogin, btnFindId, btnFindPw, btnRegisterMember, vwEmail, vwPw, imgPwHidden].forEach({
            $0?.isUserInteractionEnabled = true
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        })
        inputEmail.delegate = self
        inputEmail.tag = 1
        inputEmail.keyboardType = .emailAddress
        inputPw.delegate = self
        inputPw.tag = 2
        inputPw.keyboardType = .emailAddress
        
    }
    func update() {
        inputEmail.isHidden = !viewModel.showEmailText
        inputPw.isHidden = !viewModel.showPwText
        inputEmailTitlePosition.constant = viewModel.showEmailText ? 12.0 : 30.0
//        if viewModel.showEmailText {
//            inputEmail.becomeFirstResponder()
//        }else{
//            inputEmail.resignFirstResponder()
//        }
//        if viewModel.showPwText {
//            inputPw.becomeFirstResponder()
//        }else{
//            inputPw.resignFirstResponder()
//        }
        inputPwTitlePosition.constant = viewModel.showPwText ? 12.0 : 30.0
        imgPwHidden.image = viewModel.passwordHidden ?  UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        helpEmail.text = viewModel.helpEmailText
        helpPw.text = viewModel.helpPwText
        inputPw.isSecureTextEntry = viewModel.passwordHidden
    }
}
class EmailLoginViewModel {
    var showEmailText = false
    var showPwText = false
    var passwordHidden = true
    var helpEmailText = ""
    var helpPwText = ""
    var emailText = ""
    var passwordText = ""
}

extension EmailLoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let tag = textField.tag
        guard let text = textField.text else { return }
        
        if tag == 1 {
            self.viewModel.helpEmailText = text.isValidEmail() ? "" : "올바르지 않은 유형의 이메일입니다."
            self.viewModel.emailText = text
        } else if (tag == 2) {
            self.viewModel.helpPwText =  text.count < 8 ? "패스워드는 8자이상 입력해주세요." : ""
            self.viewModel.passwordText = text
        }
        update()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        guard let text = textField.text else { return }
        if tag == 1 {
            self.viewModel.showEmailText = !(text.count == 0)
        } else if (tag == 2) {
            self.viewModel.showPwText = !(text.count == 0)
        }
        update()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        if tag == 1 {
            self.viewModel.showPwText = true
            self.inputPw.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        update()
        return true
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let tag = textField.tag
//
//        if tag == 1 {
//            textField.text?.isValidEmail()
//        }
//         return true
//     }
}
