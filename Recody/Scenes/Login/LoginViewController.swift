//
//  LoginViewController.swift
//  Recody
//
//  Created by 최지철 on 2023/08/02.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var googlLoginBtn: UIButton!
    @IBOutlet weak var appleLoginBtn: UIButton!
    @IBOutlet weak var kakoLoginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    private let viewmodel = SNSLoginViewModel()
    private let disposeBag = DisposeBag()
    private var appleUser = AppleUser(userIdentifier: nil, familyName: nil, givenName: nil, email: nil)

    private func configure() {
        //뷰나,컴포넌트들의 속성을 그리는 함수입니다.
        let underlineText = "회원가입"
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: underlineText, attributes: underlineAttribute)
        registerBtn.setAttributedTitle(underlineAttributedString, for: .normal)
        registerBtn.tintColor = UIColor.darkGray

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.bind()
    }
    @IBAction func emailBtnClick(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailLoginViewController") as? EmailLoginViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func registerBtnClick(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func googleLoginPase() { // 로그인 유저 정보를 들고오는 함수입니다~

            GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                guard error == nil else { return }
                guard let signInResult = signInResult else { return }
                
                let user = signInResult.user
                
                let emailAddress = user.profile?.email
                
                let fullName = user.profile?.name
                let givenName = user.profile?.givenName
                let familyName = user.profile?.familyName
                
                let profilePicUrl = user.profile?.imageURL(withDimension: 320)
                print(emailAddress as Any)
                print(fullName as Any)
                print(givenName as Any)
                print(familyName as Any)
                print(profilePicUrl as Any)
     
            }
        }
    @IBAction func googleLoginClcik(_ sender: Any) {
        self.googleLoginPase()
    }
    
}
extension LoginViewController {
    func bind() {
        // 애플 로그인 버튼 Action
        appleLoginBtn.rx.tap
            .bind(to: viewmodel.appleLoginTapped)
            .disposed(by: disposeBag)
        
        // 성공시 userInfoLabel에 정보들 setText
        viewmodel.appleLoginTapped
            .subscribe(onNext: { value in
                print("ASd")
            })
            .disposed(by: disposeBag)
        
        googlLoginBtn.rx.tap
            .bind(to: viewmodel.googleLoginTapped)
            .disposed(by: disposeBag)
        
        viewmodel.kakoLoginTapped
            .subscribe(onNext: { value in
                print("카카오버튼누름")
            })
            .disposed(by: disposeBag)
    }
}


