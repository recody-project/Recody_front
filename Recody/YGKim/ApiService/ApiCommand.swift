//
//  ApiCommand.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/07.
//

import Foundation

enum ApiCommand {
    case login(_ id:String,_ pw:String)
    
    var headers : Dictionary<String,Any>?{
        return nil
    }
    var subDomain : String {
        switch self {
            case .login(_, _):
                return ""
            default:
                return ""
        }
    }
}
