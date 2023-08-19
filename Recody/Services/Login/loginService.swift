//
//  loginService.swift
//  Recody
//
//  Created by 최지철 on 2023/08/03.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class LoginService {
    func emailLoginRequest(email: String, password: String) -> Observable<LoginResponse> {
        let url = "http://recody-dev.ap-northeast-2.elasticbeanstalk.com/api/v2/users/sign-in"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let params: Parameters = ["email": email, "password": password]

        return Observable.create { observer -> Disposable in
            let request = AF.request(url,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default,
                                     headers: headers)

            request.responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value) // API 호출 성공 시 결과를 옵저버블에 방출합니다.
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}

