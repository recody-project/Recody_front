//
//  LoginModel.swift
//  Recody
//
//  Created by 최지철 on 2023/08/02.
//

import Foundation
struct LoginResponse: Codable {
    let message: String
    let data: LoginData
}
struct LoginData: Codable {
    let signInInfo: LoginInfo
}
struct LoginInfo: Codable {
    let socialType: String
    let role: String
    let accessToken: String
    let refreshToken: String
    let accessExpireTime: String
    let refreshExpireTime: String
}
