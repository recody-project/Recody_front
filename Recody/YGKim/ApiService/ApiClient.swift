//
//  ApiClient.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/07.
//

import Foundation
import Alamofire

class ApiClient {
    let server = "http://recody-dev.ap-northeast-2.elasticbeanstalk.com/api/v1"

    private func getParam(command:ApiCommand) -> Dictionary<String,Any>{
        var param = Dictionary<String,Any>()
        
        switch command {
            case .login(let id,let pw):
                param["id"] = id
                param["pw"] = pw
                break
            case .checkValidEmail(let email):
                param["email"] = email
        }
        return param
    }
    private func getHeaders(command:ApiCommand) -> HTTPHeaders{
        var headers = [HTTPHeader]()
        let header = command.headers
        for (index,value) in header.enumerated() {
            headers.append(HTTPHeader(name: value.key, value: "\(value.value)"))
        }
        return HTTPHeaders(headers)
    }
    func request(command : ApiCommand,
                _ succesBlock : @escaping (WorkResult)-> Void,
                _ errorBlock : @escaping (String) -> Void){
        
        let headers = getHeaders(command: command)
        let params = getParam(command: command)
        let url = self.server + command.subDomain
        AF.request(url,
                   method: .post,
                   parameters:params,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON(completionHandler: { response in
            do{
                switch response.result{
                    case .success(let data):
                        if let jsonData = data as? Dictionary<String,Any> {
                            succesBlock(WorkResult(jsonData))
                        }else {
                            errorBlock("data 가 없습니다.")
                        }
                        break
                    case .failure(let error):
                        errorBlock(error.localizedDescription)
                        break
                }
            }catch(let error){
                errorBlock(error.localizedDescription)
            }
        })
    }
}


// TEST CODE
//let api = ApiClient()
//api.request(command: .checkValidEmail("ikmujn5@naver.com"), { model in
////            let reulst = WorkResult(model)
//    let child = model.fetch(ChildDataModel.self)
//    print(child)
//}, { msg in
//    print(msg)
//})
