//
//  EmailLoginViewController.swift
//  Recody
//
//  Created by 최지철 on 2023/08/03.
//

import UIKit

class EmailLoginViewController: UIViewController {
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var findEmailBtn: UIButton!
    @IBOutlet weak var findPwBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    private func configure() {
        //뷰나,컴포넌트들의 속성을 그리는 함수입니다.
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
    private func setup(){
        self.emailTextField.delegate = self
        self.pwTextField.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.setup()
    }
    
    @IBAction func backBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func loginBtnClick(_ sender: Any) {
        
    }
}
extension EmailLoginViewController: UITextFieldDelegate {
    
}
