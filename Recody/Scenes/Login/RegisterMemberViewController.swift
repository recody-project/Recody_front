//
//  RegisterMemberViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/05.
//

import Foundation
import UIKit
class RegisterMemberViewController: CommonVC {
    let viewModel = RegisterMemberViewModel()
    
    private enum UseCase: Int,OrderType {
        case inputEmailShow = 0
        case inputPwShow = 1
        case inputPwConfirmShow = 2
        case inputNickNameShow = 3
        case inputPhoneShow = 4
        
        case togglePassword = 6
        case togglePasswordConfirm = 7
        
        case register = 200
        var number: Int {
            return self.rawValue
        }
    }
    private enum InputType: Int {
        case email = 0
        case password = 1
        case passwordConfirm = 2
        case nickName = 3
        case phone = 4
        func textField(_ vc: RegisterMemberViewController) -> UITextField{
            switch self {
            case .email: return vc.inputEmail
            case .password: return vc.inputPw
            case .passwordConfirm: return vc.inputPwConfirm
            case .nickName: return vc.inputNickName
            case .phone: return vc.inputPhone
            }
        }
    }
    
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwPw: UIView!
    @IBOutlet weak var vwPwConfirm: UIView!
    @IBOutlet weak var vwNickName: UIView!
    @IBOutlet weak var vwPhone: UIView!
    
    @IBOutlet weak var imgPwHidden: UIImageView!
    @IBOutlet weak var imgPwCofirmHidden: UIImageView!

    @IBOutlet weak var helpEmail: UILabel! //
    @IBOutlet weak var helpPw: UILabel! //
    @IBOutlet weak var helpPwConfirm: UILabel! //
    @IBOutlet weak var helpNickName: UILabel! //
    @IBOutlet weak var helpPhone: UILabel! //
    
    @IBOutlet weak var inputEmail: UITextField! // tag = 0
    @IBOutlet weak var inputPw: UITextField! // tag = 1
    @IBOutlet weak var inputPwConfirm: UITextField! // tag = 2
    @IBOutlet weak var inputNickName: UITextField! // tag = 3
    @IBOutlet weak var inputPhone: UITextField! // tag = 4
    
    @IBOutlet weak var inputEmailTitlePosition: NSLayoutConstraint! // disable 30 enable 12
    @IBOutlet weak var inputPwTitlePosition: NSLayoutConstraint!
    @IBOutlet weak var inputPwConfirmTitlePosition: NSLayoutConstraint!
    @IBOutlet weak var inputPwNickNameTitlePosition: NSLayoutConstraint!
    @IBOutlet weak var inputPwPhoneTitlePosition: NSLayoutConstraint!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBAction func backAction(_ sender: Any) {
        self.router?.popViewContoller(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    override func display(orderNumber: Int) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        
        switch useCase {
        case .inputEmailShow:
            viewModel.showEmailText = true
            inputEmail.becomeFirstResponder()
        case .inputPwShow:
            viewModel.showPwText = true
            inputPw.becomeFirstResponder()
        case .inputPwConfirmShow:
            viewModel.showPwConfirmText = true
            inputPwConfirm.becomeFirstResponder()
        case .inputNickNameShow:
            viewModel.showNickNameText = true
            inputNickName.becomeFirstResponder()
        case .inputPhoneShow:
            viewModel.showPhoneText = true
            inputPhone.becomeFirstResponder()
        case .togglePassword:
            viewModel.passwordHidden.toggle()
        case .togglePasswordConfirm:
            viewModel.passwordConfirmHidden.toggle()
        case .register:
            if checkInput() {
                let email = viewModel.emailText
                let password = viewModel.passwordText
                let passwordConfirm = viewModel.passwordConfirmText
                let name = ""
                let nickName = viewModel.nickNameText
                self.interactor?.just(useCase).api(.registerMemeber(email,password,passwordConfirm,name,nickName))
            }
        default:
            self.presenter?.alertService.showToast("\(useCase)")
        }
        update()
    }
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        
        switch useCase {
        default:
            if let data = dataStore?.data(useCase)?.fetch(DefaultDataModel.self) {
                print(dataStore)
            }
        }
    }
    override func displayErorr(orderNumber: Int, msg: String?) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
//        case .register:
//            self.presenter?.alertService.show(title: "알림", msg: "\(msg)", actions: <#T##[UIAlertAction]#>)
        default:
            print("\(useCase)  :: \(msg)")
        }
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag,
              let useCase = UseCase(rawValue: tag) else { return }
        self.interactor?.just(useCase).drop()
    }
    func setup() {
//        btnLogin.tag = UseCase.loginAction.rawValue
//        btnFindId.tag = UseCase.findIdAction.rawValue
//        btnFindPw.tag = UseCase.findPwAction.rawValue
//        vwEmail.tag = UseCase.inputEmailShow.rawValue
//        vwPw.tag = UseCase.inputPwShow.rawValue
//        imgPwHidden.tag = UseCase.togglePassword.rawValue
//
//        btnRegisterMember.tag = UseCase.registerMemberAction.rawValue
//        [btnLogin, btnFindId, btnFindPw, btnRegisterMember, vwEmail, vwPw, imgPwHidden].forEach({
//            $0?.isUserInteractionEnabled = true
//            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
//        })
        let tags : [InputType] = [.email, .password, .passwordConfirm, .nickName, .phone]
        for (index, input) in [inputEmail, inputPw, inputPwConfirm, inputNickName, inputPhone].enumerated(){
            input?.tag = tags[index].rawValue
            input?.delegate = self
        }
        let showInputAction : [UseCase] = [.inputEmailShow, .inputPwShow, .inputPwConfirmShow, .inputNickNameShow, .inputPhoneShow]
        for (index, btn) in [vwEmail, vwPw, vwPwConfirm, vwNickName, vwPhone].enumerated(){
            btn?.isUserInteractionEnabled = true
            btn?.tag = showInputAction[index].rawValue
            btn?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        }
        btnRegister.tag = UseCase.register.rawValue
        btnRegister.isUserInteractionEnabled = true
        btnRegister.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        
        imgPwHidden.tag = UseCase.togglePassword.rawValue
        imgPwHidden.isUserInteractionEnabled = true
        imgPwHidden.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        
        imgPwCofirmHidden.tag = UseCase.togglePasswordConfirm.rawValue
        imgPwCofirmHidden.isUserInteractionEnabled = true
        imgPwCofirmHidden.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
    }
    func update() {
        helpEmail.text = viewModel.helpEmailText
        helpPw.text = viewModel.helpPwText
        helpPwConfirm.text = viewModel.helpPwConfirmText
        helpNickName.text = viewModel.helpNickNameText
        helpPhone.text = viewModel.helpPhoneText
        
        inputPw.isSecureTextEntry = viewModel.passwordHidden
        inputPwConfirm.isSecureTextEntry = viewModel.passwordConfirmHidden
        
        inputEmailTitlePosition.constant = viewModel.showEmailText ? 12.0 : 30.0
        inputPwTitlePosition.constant = viewModel.showPwText ? 12.0 : 30.0
        inputPwConfirmTitlePosition.constant = viewModel.showPwConfirmText ? 12.0 : 30.0
        inputPwNickNameTitlePosition.constant = viewModel.showNickNameText ? 12.0 : 30.0
        inputPwPhoneTitlePosition.constant = viewModel.showPhoneText ? 12.0 : 30.0
        
        inputEmail.isHidden = !viewModel.showEmailText
        inputPw.isHidden = !viewModel.showPwText
        inputPwConfirm.isHidden = !viewModel.showPwConfirmText
        inputNickName.isHidden = !viewModel.showNickNameText
        inputPhone.isHidden = !viewModel.showPhoneText
        
        imgPwHidden.image = viewModel.passwordHidden ?  UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        imgPwCofirmHidden.image = viewModel.passwordConfirmHidden ?  UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
    }
    func checkInput() -> Bool {
        if viewModel.helpEmailText != "" {
            self.presenter?.alertService.show(title: "알림", msg: viewModel.helpEmailText, actions: [UIAlertAction(title: "확인", style: .default)])
            return false
        }
        if viewModel.helpPwText != "" {
            self.presenter?.alertService.show(title: "알림", msg: viewModel.helpPwText, actions: [UIAlertAction(title: "확인", style: .default)])
            return false
        }
        if viewModel.helpPwConfirmText != "" {
            self.presenter?.alertService.show(title: "알림", msg: viewModel.helpPwConfirmText, actions: [UIAlertAction(title: "확인", style: .default)])
            return false
        }
        if viewModel.helpNickNameText != "" {
            self.presenter?.alertService.show(title: "알림", msg: viewModel.helpNickNameText, actions: [UIAlertAction(title: "확인", style: .default)])
            return false
        }
        if viewModel.helpPhoneText != "" {
            self.presenter?.alertService.show(title: "알림", msg: viewModel.helpPhoneText, actions: [UIAlertAction(title: "확인", style: .default)])
            return false
        }
        return true
    }
}
class RegisterMemberViewModel {
    var showEmailText = false
    var showPwText = false
    var showPwConfirmText = false
    var showNickNameText = false
    var showPhoneText = false
    
    var passwordHidden = true
    var passwordConfirmHidden = true
    
    var helpEmailText = ""
    var helpPwText = ""
    var helpPwConfirmText = ""
    var helpNickNameText = ""
    var helpPhoneText = ""
    
    var emailText = ""
    var passwordText = ""
    var passwordConfirmText = ""
    var nickNameText = ""
    var phoneText = ""
    
}

extension RegisterMemberViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let type = InputType(rawValue: textField.tag),
              let text = textField.text else { return }
        switch type {
        case .email:
            self.viewModel.emailText = text
            self.viewModel.helpEmailText = text.isValidEmail() ? "" : "올바르지 않은 유형의 이메일입니다."
        case .password:
            self.viewModel.passwordText = text
            self.viewModel.helpPwText =  text.count < 6 ? "패스워드는 6자이상 입력해주세요." : ""
        case .passwordConfirm:
            self.viewModel.passwordConfirmText = text
        case .nickName:
            self.viewModel.nickNameText = text
            self.viewModel.helpNickNameText = text.count > 5 ? "닉네임은 1~5자 사이로 입력해주세요." : ""
        case .phone:
            self.viewModel.phoneText = text
        }
        self.viewModel.helpPwConfirmText = viewModel.passwordText != viewModel.passwordConfirmText ?  "패스워드가 일치하지 않습니다." : ""
        update()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let type = InputType(rawValue: textField.tag),
              let text = textField.text else { return }
        let isEmpty = textField.text?.count == 0
        switch type {
        case .email:
            viewModel.showEmailText = !isEmpty
        case .password:
            viewModel.showPwText = !isEmpty
        case .passwordConfirm:
            viewModel.showPwConfirmText = !isEmpty
        case .nickName:
            viewModel.showNickNameText = !isEmpty
        case .phone:
            viewModel.showPhoneText = !isEmpty
        }
        self.viewModel.helpPwConfirmText = viewModel.passwordText != viewModel.passwordConfirmText ?  "패스워드가 일치하지 않습니다." : ""
        update()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        textField.resignFirstResponder()
        let next = tag + 1
        if next != 5 {
            guard let useCase = UseCase(rawValue: next) else { return true }
            self.interactor?.just(useCase).drop()
        }
        update()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }else{
            //글자수 제한
            if textField.tag == InputType.phone.rawValue {
                if textField.text?.count ?? 0 >= 11 {
                    return false
                }
            }
            self.viewModel.helpPwConfirmText = viewModel.passwordText != viewModel.passwordConfirmText ?  "패스워드가 일치하지 않습니다." : ""
             return true
        }
    }
   
}
