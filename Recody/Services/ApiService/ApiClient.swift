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

    static func getParam(command: ApiCommand) ->Dictionary<String, Any> {
        var param = Dictionary<String, Any>()
        switch command {
        case .loginGoogle(let resourceAccessToken,let resourceRefreshToken):
            param["resourceAccessToken"] = resourceAccessToken
            param["resourceRefreshToken"] = resourceRefreshToken
        case .registerMemeber(let email, let password, let passwordConfirm, let name, let nickname, let pictureUrl):
            param["email"] = email
            param["password"] = password
            param["passwordConfirm"] = passwordConfirm
            param["name"] = name
            param["nickname"] = nickname
            param["pictureUrl"] = pictureUrl
        case .login(let email, let password):
            param["email"] = email
            param["password"] = password
        case .checkValidEmail(let email):
            param["email"] = email
        case .resetPasswordToEmail(let email):
            param["email"] = email
        case .changeNickName(let nickname):
            param["nickname"] = nickname
        case .search(let categoriId, let keyword, let language):
            param["categoriId"] = categoriId
            param["keyword"] = keyword
            param["language"] = language
        case .getMovieDetail(let tmdbId, let language):
            param["tmdbId"] = tmdbId
            param["language"] = language
        case .addWish(let contentId):
            param["contentId"] = contentId
        case .removeWish(let contentId):
            param["contentId"] = contentId
        case .getStarScore(let contentId):
            param["contentId"] = contentId
        case .setStarScore(let contentId, let score):
            param["contentId"] = contentId
            param["score"] = score
        case .addCustomCategory(let name, let iconUrl):
            param["name"] = name
            param["iconUrl"] = iconUrl
        case .modifyCustomCategory(let categoriId, let name, let iconUrl):
            param["name"] = name
            param["iconUrl"] = iconUrl
        case .addRecord(let contentId, let title, let note, let appreciationDate, let appreciationNumber):
            param["contentId"] = contentId
            param["title"] = title
            param["note"] = note
            param["appreciationDate"] = appreciationDate
            param["appreciationNumber"] = appreciationNumber
        case .getMyRecordList(let contentId, let categoryId, let page,let size):
            if contentId != nil {
                param["contentId"] = contentId!
            }
            if categoryId != nil {
                param["categoryId"] = categoryId!
            }
            if page != nil {
                param["page"] = page!
            }
            param["size"] = size
        case .getMyRecordCount(let thisMonth):
            param["thisMonth"] = thisMonth
        case .addCustomGenre(let categoriId, let genreName, let genreIconUrl):
            param["categoriId"] = categoriId
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
        for (index, value) in header.enumerated() {
            headers.append(HTTPHeader(name: value.key, value: "\(value.value)"))
        }
        return HTTPHeaders(headers)
    }
    static func request(command: ApiCommand,
                _ succesBlock: @escaping (WorkResult)-> Void,
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
                    if let jsonData = data as? Dictionary<String,Any> {
                        print("========== API Success ==========")
                        print("url : \(url)")
                        print("statusCode : \(String(describing: response.response?.statusCode))")
                        print("Data : \(jsonData)")
                        print("====== API Success END ==========")
                        succesBlock(WorkResult(jsonData))
                    }else {
                        errorBlock("data ??? ????????????.")
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
