//
//  LoginViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/10.
//

import Foundation
import UIKit

class LoginViewController : CommonVC {
    let btnLogin = UIImageView()
    
    enum UseCase : Int,OrderType {
        case loginWithKakao = 100
        var number: Int{
            return self.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpClick()
    }
    private func checkCase(_ useCase:Int?) -> UseCase {
        guard let action  = UseCase.init(rawValue: useCase!) else {  fatalError("login UseCase 를 추가해주세요 :: rawValue = \(String(describing: useCase))")  }
        return action
    }
    private func setUpClick(){
        btnLogin.isUserInteractionEnabled = true
        btnLogin.tag = UseCase.loginWithKakao.rawValue
        btnLogin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(login)))
    }
    @objc private func login(_ sender: UITapGestureRecognizer){
        let action = checkCase(sender.view?.tag)
        switch action {
            case .loginWithKakao:
                print("카카오톡 로그인 시도")
                self.interactor?.just(action).drop()
                break
            default:
                break
        }
    }
    override func display(orderNumber: Int) {
        let action = checkCase(orderNumber)
        
        
    }
}
