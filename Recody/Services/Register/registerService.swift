////
////  registerService.swift
////  Recody
////
////  Created by 최지철 on 2023/08/03.
////
//import Foundation
//import Alamofire
//import RxSwift
//
//class RegisterService {
//    func signUp(email: String, password: String, passwordConfirm: String,completion: @escaping (Result<DataInfo, Error>) -> Void){
//        let url = APIConstants.baseURL + "/v2/users/signup"
//        let parameters: [String: Any] = [
//            "email": email,
//            "password": password,
//            "passwordConfirm": passwordConfirm
//        ]
//        AF.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default).responseDecodable(of:UserSignupResponse.self) { response in
//            switch response.result {
//            case .success(let response):
//                completion(.success(response.data))
//                print(response)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//        
//    }
//}
