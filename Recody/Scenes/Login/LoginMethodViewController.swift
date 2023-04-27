//
//  LoginMethodViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/04.
//

import Foundation
import UIKit

protocol LoginMethodViewControllerDelegate{
    func findID()
    func loginEmail()
    func loginSNS(_ method:LoginMethodViewController.LoginMethod)
}

class LoginMethodViewController: UIViewController {
    var modal: HalfModalPresentationController?
    var delegate: LoginMethodViewControllerDelegate?
    
    @IBOutlet weak var btnSNS1: UIImageView!
    @IBOutlet weak var btnSNS2: UIImageView!
    @IBOutlet weak var btnSNS3: UIImageView!
    @IBOutlet weak var btnSNS4: UIImageView!
    @IBOutlet weak var btnEmail: UIView!
    @IBOutlet weak var btnFindID: UIStackView!
    
    enum LoginMethod : Int {
        case kakao = 0
        case facebook = 1
        case naver = 2
        case apple = 3
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    static func getInstanse() -> LoginMethodViewController{
        guard let vc = UIStoryboard(name: "LoginMethodViewController", bundle: nil).instantiateInitialViewController() as? LoginMethodViewController
        else {
            fatalError()
        }
        return vc
    }
    func setup() {
        btnSNS1.tag = 0
        btnSNS2.tag = 1
        btnSNS3.tag = 2
        btnSNS4.tag = 3
        [btnSNS1,btnSNS2,btnSNS3,btnSNS4].forEach({
            $0?.isUserInteractionEnabled = true
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginSNS)))
        })
        btnEmail.isUserInteractionEnabled = true
        btnEmail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginEmail)))
        btnFindID.isUserInteractionEnabled = true
        btnFindID.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionFindID)))
    }
    @objc func loginSNS(_ sender:UITapGestureRecognizer){
        guard let tag = sender.view?.tag ,
              let method = LoginMethod(rawValue: tag) else { return }
        modal?.dismissController({
            self.delegate?.loginSNS(method)
        })
    }
    @objc func loginEmail(){
        modal?.dismissController({
            self.delegate?.loginEmail()
        })
    }
    @objc func actionFindID(){
        modal?.dismissController({
            self.delegate?.findID()
        })
    }
}
