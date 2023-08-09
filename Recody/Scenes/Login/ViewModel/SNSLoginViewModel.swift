//
//  SNSLoginViewModel.swift
//  Recody
//
//  Created by 최지철 on 2023/08/07.
//

import Foundation
import RxSwift
import RxCocoa
import AuthenticationServices
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
final class SNSLoginViewModel: NSObject {
    private let disposeBag = DisposeBag()
    let googleLoginTapped = PublishRelay<Void>()
    let appleLoginTapped = PublishRelay<Void>()
    let kakoLoginTapped = PublishRelay<Void>()
    
    var isGoogleLoginSucceed = PublishSubject<GoogleLoginResponse>()
    override init() {
        super.init()
        kakoLoginTapped
            .subscribe(onNext: { [weak self] in
                self?.kakaologinWithWeb()
                print("카카오로그인")
            })
            .disposed(by: disposeBag)
        appleLoginTapped
            .subscribe(onNext: { [weak self] in
                self?.performAppleSignIn()
            })
            .disposed(by: disposeBag)
        googleLoginTapped
            .subscribe(onNext: { [weak self] in
                GIDSignIn.sharedInstance.signIn(withPresenting: LoginViewController()) { signInResult, error in
                     guard error == nil else { return }
                   }
            })
            .disposed(by: disposeBag)
    }
    func kakaologinWithWeb() {//카카오 앱 미 설치시 웹으로 연결
        UserApi.shared.me() {(user, error) in
        if let error = error {
            print(error)
        }
        else {
            print("me() success.")
            _ = user
            print(user?.kakaoAccount?.profile?.nickname as Any)
            print(user?.kakaoAccount?.profile?.profileImageUrl as Any)

            if let url = user?.kakaoAccount?.profile?.profileImageUrl,
               let data = try? Data(contentsOf: url) {
                print(data)
                
                
            }
        }
    }
        }
    func kakaoSingIn(){

        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    self.kakaologinWithWeb()
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                }
            }
        }

    }

    func performAppleSignIn() { //애플로그인
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }


}
extension SNSLoginViewModel: ASAuthorizationControllerDelegate {
  
    // 애플 로그인 성공
      func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
          if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
              let userIdentifier = appleIDCredential.user
              let email = appleIDCredential.email
              
              print("성공",userIdentifier,email)

          }
      }
      
      // 애플 로그인 실패
      func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
          print("Apple Sign In Error: \(error.localizedDescription)")
      }

}
