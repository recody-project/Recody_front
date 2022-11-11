//
//  ApiCommand.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/07.
//

import Foundation

enum ApiCommand {
    case login(_ id:String,_ pw:String)
    case checkValidEmail(_ email:String)
    
    var headers : Dictionary<String,Any> {
        var header = Dictionary<String,Any>()
        header["ContentType"] = "application/x-www-form-urlencoded;charset=utf-8"
        return header
    }
    var subDomain : String {
        switch self {
//            case .login(_, _):
//                return ""
            case .checkValidEmail(_):
                return "/users/signup/check-duplicate"
            default:
                return ""
        }
    }
}
