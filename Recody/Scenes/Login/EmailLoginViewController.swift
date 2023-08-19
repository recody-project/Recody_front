//
//  EmailLoginViewController.swift
//  Recody
//
//  Created by 최지철 on 2023/08/03.
//

import UIKit
import RxSwift
import RxCocoa

protocol baseViewControllerAttrubute
{
    func bind()
    func configure()
}
class EmailLoginViewController: UIViewController {
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var findEmailBtn: UIButton!
    @IBOutlet weak var findPwBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    private func setup()
    {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        bind()
        configure()
    }
    
    @IBAction func backBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func loginBtnClick(_ sender: Any) {
        
    }
}
extension EmailLoginViewController: baseViewControllerAttrubute {
    func bind()
    {
        let input = LoginViewModel.Input(loginID: emailTextField.rx.text, loginPW: pwTextField.rx.text, loginTap: loginBtn.rx.tap)
        let output = viewModel.transform(from: input)
        output.emailRelay
            .bind(to: emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.passwordRelay
            .bind(to: pwTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.emailText
            .bind(to: viewModel.emailRelay)
            .disposed(by: disposeBag)
        
        output.passwordText
            .bind(to: viewModel.passwordRelay)
            .disposed(by: disposeBag)
        
        output.isValid
            .drive(loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isValid
            .map { $0 == true ? UIColor(hexString: "#373737") : UIColor.white }
            .drive(loginBtn.rx.backgroundColor)
            .disposed(by: disposeBag)
        output.isValid
            .map { $0 == true ? UIColor.white : UIColor.black }
            .drive(loginBtn.rx.tintColor)
            .disposed(by: disposeBag)

        
        output.isLoginSucceed
            .withUnretained(self)
            .subscribe { [weak self] vc, response in
                guard let self = self else { return }
                vc.presentAlert(response.message, response.data.signInInfo.accessExpireTime)
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.presentAlert("로그인 실패", "\(error)")
            } onCompleted: {
                print("완료")
            } onDisposed: {
                print("버려")
            }
            .disposed(by: disposeBag)
    }
    func configure(){
        let underlineText = "회원가입"
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: underlineText, attributes: underlineAttribute)
        registerBtn.setAttributedTitle(underlineAttributedString, for: .normal)
        registerBtn.tintColor = UIColor.darkGray
        findPwBtn.titleLabel?.font = UIFont.fontWithName(type: FontType.regular, size: 12)
        findEmailBtn.titleLabel?.font = UIFont.fontWithName(type: FontType.regular, size: 12)
        findPwBtn.titleLabel?.textColor = UIColor(hexString: "#999999")
        findEmailBtn.titleLabel?.textColor = UIColor(hexString: "#999999")
    }
    private func presentAlert(_ title: String, _ message: String)
    {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}
