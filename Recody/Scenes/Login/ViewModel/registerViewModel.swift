//
//  registerViewModel.swift
//  Recody
//
//  Created by 최지철 on 2023/08/03.
//

import Foundation
import RxCocoa
import RxSwift

class RegisterViewModel {
    private let disposeBag = DisposeBag()
//    private let registerApi = RegisterService()

      let email = BehaviorRelay<String>(value: "")
      let password = BehaviorRelay<String>(value: "")
      let passwordConfirm = BehaviorRelay<String>(value: "")
      let signUpButtonTapped = PublishRelay<Void>()

      let userInfo = PublishRelay<UserInfo>()
      let error = PublishRelay<Error>()

      init() {
//          signUpButtonTapped
//              .withLatestFrom(Observable.combineLatest(email, password, passwordConfirm))
//              .flatMapLatest { [weak self] (email, password, passwordConfirm) -> Observable<UserInfo> in
//                  guard let self = self else { return Observable.empty() }
//                  return self.registerApi.signUp(email: email, password: password, passwordConfirm: passwordConfirm)
//                      .asObservable()
//                      .catchAndReturn(UserInfo(userId: -1, email: "", name: nil, socialType: "", nickname: "", role: "", pictureUrl: nil))
//              }
//              .subscribe(onNext: { [weak self] userInfo in
//                  guard let self = self else { return }
//                  self.userInfo.accept(userInfo)
//              }, onError: { [weak self] error in
//                  self?.error.accept(error)
//              })
//              .disposed(by: disposeBag)
      }
}
