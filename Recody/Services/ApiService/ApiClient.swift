//
//  ApiClient.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/07.
//

import Foundation
import Alamofire

class ApiClient {
    static let server = "http://recody-dev.ap-northeast-2.elasticbeanstalk.com/api"

    // 쿼리스트링 제외
    static func getParam(command: ApiCommand) -> [String: Any] {
        var param = [String: Any]()
        switch command {
        case .loginGoogle(let resourceAccessToken, let resourceRefreshToken):
            param["resourceAccessToken"] = resourceAccessToken
            param["resourceRefreshToken"] = resourceRefreshToken
        case .registerMemeber(let email, let password, let passwordConfirm, let name, let nickname, let pictureUrl):
            param["email"] = email
            param["password"] = password
            param["passwordConfirm"] = passwordConfirm
            param["name"] = name
            param["nickname"] = nickname
            param["pictureUrl"] = pictureUrl
        case .checkValidEmail(let email):
            param["email"] = email
        case .resetPasswordToEmail(let email):
            param["email"] = email
        case .changePassword(let email, let password, let passwordConfirm):
            param["email"] = email
            param["password"] = password
            param["passwordConfirm"] = passwordConfirm
        case .login(let email, let password):
            param["email"] = email
            param["password"] = password
        case .changeNickName(let nickname):
            param["nickname"] = nickname
        case .search(_, _, let genreId, let size, let page):
            param["genreId"] = genreId
            param["size"] = size
            param["page"] = page
        case .addWish(let contentId):
            param["contentId"] = contentId
        case .removeWish(let contentId):
            param["contentId"] = contentId
        case .setStarScore(let contentId, let score):
            param["contentId"] = contentId
            param["score"] = score
        case .addCustomCategory(let name, let iconUrl):
            param["name"] = name
            param["iconUrl"] = iconUrl
        case .modifyCustomCategory(_, let name, let iconUrl):
            param["name"] = name
            param["iconUrl"] = iconUrl
        case .modifyContentCategory(_, let categoryId):
            param["categoryId"] = categoryId
        case .modifytContentGenre(_, let genreIds):
            param["genreIds"] = genreIds
        case .addRecord(let contentId, let title, let note, let appreciationDate, let appreciationNumber):
            param["contentId"] = contentId
            param["title"] = title
            param["note"] = note
            param["appreciationDate"] = appreciationDate
            param["appreciationNumber"] = appreciationNumber
        case .addCustomGenre(let categoryId, let genreName, let genreIconUrl):
            param["categoryId"] = categoryId
            param["genreName"] = genreName
            param["genreIconUrl"] = genreIconUrl
        default:
        break
        }
        return param
    }

    static func getHeaders(command: ApiCommand) -> HTTPHeaders {
        var headers = [HTTPHeader]()
        let header = command.headers
//        for (index, value) in header.enumerated() {
//            headers.append(HTTPHeader(name: value.key, value: "\(value.value)"))
//        }
        for (_, value) in header.enumerated() {
            headers.append(HTTPHeader(name: value.key, value: "\(value.value)"))
        }
        return HTTPHeaders(headers)
    }
    static func request(
        command: ApiCommand,
        _ succesBlock: @escaping (WorkResult) -> Void,
        _ errorBlock: @escaping (String) -> Void) {
        let headers = getHeaders(command: command)
        let params = getParam(command: command)
        let url = self.server + command.subDomain
        
        print("========== API Request ==========")
        print("url : \(url)")
        print("header : \(headers)")
        print("param : \(params)")
        print("====== API Request END ==========")
        AF.request(url,
                   method: command.method,
                   parameters: params,
                   encoding: command.encoding,
                   headers: headers).responseJSON(completionHandler: { response in
            do {
                switch response.result {
                case .success(let data):
                    if let jsonData = data as? [String: Any] {
                        print("========== API Success ==========")
                        print("url : \(url)")
                        print("statusCode : \(String(describing: response.response?.statusCode))")
                        print("Data : \(jsonData)")
                        print("====== API Success END ==========")
                        succesBlock(WorkResult(jsonData))
                    } else {
                        errorBlock("data 가 없습니다.")
                        print("========== API Failed ==========")
                        print("url : \(url)")
                        print("statusCode : \(String(describing: response.response?.statusCode))")
                        print("error msg = \(String(describing: response.error?.localizedDescription))")
                        print("====== API Request END ==========")
                    }
                case .failure(let error):
                    print("========== API Failed ==========")
                    print("url : \(url)")
                    print("statusCode : \(String(describing: response.response?.statusCode))")
                    print("error msg = \(String(describing: response.error?.localizedDescription))")
                    print("====== API Request END ==========")
                    errorBlock(error.localizedDescription)
                }
            } catch ( let error ) {
                print("========== API Failed ==========")
                print("url : \(url)")
                print("statusCode : \(String(describing: response.response?.statusCode))")
                print("error msg = \(String(describing: response.error?.localizedDescription))")
                print("====== API Request END ==========")
                errorBlock(error.localizedDescription)
            }
        })
    }
    static func requestTEST(_ headers: [Dictionary<String,Any>],
                            _ params: [Dictionary<String,Any>],
                            _ server: String,
                            _ subDomain: String,
                            _ method: HTTPMethod,
                            _ encoding: ParameterEncoding,
                            _ succesBlock: @escaping (WorkResult) -> Void,
                            _ errorBlock: @escaping (String) -> Void) {
        
        let header = HTTPHeaders(headers.map({ dic -> HTTPHeader in
            if let head = dic.first {
                return HTTPHeader(name: head.key, value: (head.value as? String) ?? "")
            } else {
                fatalError("empty header")
            }
        }))
        var param = Dictionary<String,String>()
        params.forEach({
            if let dic = $0.first {
                param[dic.key] = (dic.value as? String) ?? ""
            }
        })
        let url = server + subDomain
        
        print("========== API Request ==========")
        print("url : \(url)")
        print("header : \(headers)")
        print("param : \(params)")
        print("====== API Request END ==========")
        AF.request(url,
                   method: method,
                   parameters: param,
                   encoding: encoding,
                   headers: header).responseJSON(completionHandler: { response in
            do {
                switch response.result {
                case .success(let data):
                    if let jsonData = data as? [String: Any] {
                        print("========== API Success ==========")
                        print("url : \(url)")
                        print("statusCode : \(String(describing: response.response?.statusCode))")
                        print("Data : \(jsonData)")
                        print("====== API Success END ==========")
                        succesBlock(WorkResult(jsonData))
                    } else {
                        errorBlock("data 가 없습니다.")
                        print("========== API Failed ==========")
                        print("url : \(url)")
                        print("statusCode : \(String(describing: response.response?.statusCode))")
                        print("error msg = \(String(describing: response.error?.localizedDescription))")
                        print("====== API Request END ==========")
                    }
                case .failure(let error):
                    print("========== API Failed ==========")
                    print("url : \(url)")
                    print("statusCode : \(String(describing: response.response?.statusCode))")
                    print("error msg = \(String(describing: response.error?.localizedDescription))")
                    print("====== API Request END ==========")
                    errorBlock(error.localizedDescription)
                }
            } catch( let error ) {
                print("========== API Failed ==========")
                print("url : \(url)")
                print("statusCode : \(String(describing: response.response?.statusCode))")
                print("error msg = \(String(describing: response.error?.localizedDescription))")
                print("====== API Request END ==========")
                errorBlock(error.localizedDescription)
            }
        })
    }
}

// TEST CODE
// let api = ApiClient()
// api.request(command: .checkValidEmail("ikmujn5@naver.com"), { model in
// //            let reulst = WorkResult(model)
//    let child = model.fetch(ChildDataModel.self)
//    print(child)
// }, { msg in
//    print(msg)
// })
