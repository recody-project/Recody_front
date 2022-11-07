//
//  ApiClient.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/07.
//

import Foundation
import Alamofire

class ApiClient {
    let server = "http://www.google.com"
    func reqeust(command : ApiCommand,
                 _ updateUI : @escaping (DefaultDataModel)-> Void,
                 _ errorBlock : @escaping (String) -> Void){
        switch command {
            case .login(_, _):
                break
        }
    }
    
    private func setParam(command:ApiCommand) -> Dictionary<String,Any>{
        var param = Dictionary<String,Any>()
        
        switch command {
            case .login(let id,let pw):
                param["id"] = id
                param["pw"] = pw
                break
        }
        return param
    }
    private func setHeaders(command:ApiCommand) -> HTTPHeaders{
        var headers = [HTTPHeader]()
        if let header = command.headers{
            for (index,value) in header.enumerated() {
                headers.append(HTTPHeader(name: value.key, value: "\(value.value)"))
            }
        }
        return HTTPHeaders(headers)
    }
    
    func some(){
        
//        self.reqeust(command: .login("abc", "def"))
    }
    private func reqest(){
        var headers = [HTTPHeader]()
        headers.append(HTTPHeader(name: "Content-Type", value: "application/json"))
        let param = Dictionary<String,Any>()
        AF.request(server,
                   method: .post,
                   parameters:param,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(headers)).responseJSON(completionHandler: { response in
            do{
                switch response.result{
                    case .success(let data):
                        
                        break
                    case .failure(let error):
                        break
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        })
    }
}
