//
//  LoginViewModel.swift
//  Recody
//
//  Created by 최지철 on 2023/08/02.
//

import Foundation
import RxSwift
import RxCocoa
import GoogleSignIn

class LoginViewModel{
    
    private let api = LoginService()
    let emailRelay = BehaviorRelay<String>(value: "")
    let passwordRelay = BehaviorRelay<String>(value: "")
    var isLoginSucceed = PublishSubject<LoginResponse>()
    let disposeBag = DisposeBag()
    var isValid: Observable<Bool> {
        return Observable
            .combineLatest(emailRelay, passwordRelay)
            .map { email, password in
                print("Email : \(email), Password : \(password)")
                return !email.isEmpty && email.contains("@") && email.contains(".") && password.count > 0 && !password.isEmpty
            }
    }
    struct Input {
        let loginID: ControlProperty<String?>
        let loginPW: ControlProperty<String?>
        let loginTap: ControlEvent<Void>
    }
    struct Output {
        let emailRelay: BehaviorRelay<String>
        let passwordRelay: BehaviorRelay<String>
        
        // 텍스트필드 입력값
        let emailText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        
        // 버튼 탭
        let loginTap: ControlEvent<Void>
        
        // 로그인 성공 유무
        let isLoginSucceed: PublishSubject<LoginResponse>
        
        // 유효성 판단
        let isValid: Driver<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let emailText = input.loginID.orEmpty
        let passwordText = input.loginPW.orEmpty
        
        let isValid = isValid.asDriver(onErrorJustReturn: false)
        input.loginTap
                   .withLatestFrom(Observable.combineLatest(emailRelay, passwordRelay))
                   .flatMapLatest { [weak self] email, password -> Observable<LoginResponse> in
                       guard let self = self else { return .empty() }
                       return self.api.emailLoginRequest(email: email, password: password)
                   }
                   .subscribe(onNext: { [weak self] response in
                       guard let self = self else { return }
                       self.isLoginSucceed.onNext(response) // API 호출 결과를 옵저버블에 방출합니다.
                   }, onError: { [weak self] error in
                       self?.isLoginSucceed.onError(error) // 에러 처리
                   })
                   .disposed(by: disposeBag)
        return Output(emailRelay: emailRelay,
                      passwordRelay: passwordRelay,
                      emailText: emailText,
                      passwordText: passwordText,
                      loginTap: input.loginTap,
                      isLoginSucceed: isLoginSucceed,
                      isValid: isValid)
    }
    
}
