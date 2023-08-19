//
//  UserService.swift
//  Recody
//
//  Created by 마경미 on 16.08.23.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class HomeService {
    func userInfoRequest() -> Observable<UserInfoResponse> {
        let url = "http://recody-dev.ap-northeast-2.elasticbeanstalk.com/api/v1/users/info"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]

        return Observable.create { observer -> Disposable in
            let request = AF.request(url,
                                     method: .post,
                                     encoding: JSONEncoding.default,
                                     headers: headers)

            request.responseDecodable(of: UserInfoResponse.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value) // API 호출 성공 시 결과를 옵저버블에 방출합니다.
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func currentRecordRequest() -> Observable<CurrentRecordResponse> {
        let url = "http://recody-dev.ap-northeast-2.elasticbeanstalk.com/api/v1/record/content/continuing"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]

        return Observable.create { observer -> Disposable in
            let request = AF.request(url,
                                     method: .post,
                                     encoding: JSONEncoding.default,
                                     headers: headers)

            request.responseDecodable(of: CurrentRecordResponse.self) { response in
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
    
    func recommendWorkRequest(category: String) -> Observable<RecommendWorkResponse> {
        let url = "http://recody-dev.ap-northeast-2.elasticbeanstalk.com/api/v1/recommendations?categoryId=cat-1"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let params: Parameters = ["categoryId": "\(category)"]

        return Observable.create { observer -> Disposable in
            let request = AF.request(url,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default,
                                     headers: headers)

            request.responseDecodable(of: RecommendWorkResponse.self) { response in
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

