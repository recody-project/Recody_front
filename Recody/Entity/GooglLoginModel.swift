//
//  GooglLoginModel.swift
//  Recody
//
//  Created by 최지철 on 2023/08/05.
//

import Foundation
struct GoogleLoginResponse: Codable {
    let message: String
    let data: GoogleLoginData
}
struct GoogleLoginData: Codable{
    let socialType: String
    let accessToken: String
    let refreshToken: String
    let accessExpireTime: String
    let refreshExpireTime: String
}
