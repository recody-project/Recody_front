//
//  LoginViewController.swift
//  Recody
//
//  Created by 최지철 on 2023/08/02.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    
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
    }
    @IBAction func emailBtnClick(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailLoginViewController") as? EmailLoginViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func googleBtnClick(_ sender: Any) {
    }
    @IBAction func appleBtnClick(_ sender: Any) {
    }
    @IBAction func kakaoBtnClick(_ sender: Any) {
    }
    @IBAction func registerBtnClick(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
extension LoginViewController {
    //소셜로그인 처리할려는extension
    private func kakoLogin(){
        
    }
    private func appleLogin(){
        
    }
    private func googleLogin(){
        
    }
}
