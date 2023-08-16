//
//  registerModel.swift
//  Recody
//
//  Created by 최지철 on 2023/08/03.
//

import Foundation

struct SignUpRequest: Codable {
    let userId: Int
    let email: String
    let name: String?
    let socialType: String
    let nickname: String
    let role: String
    let pictureUrl: String?
}
struct UserSignupResponse: Codable {
    let message: String
    let data: DataInfo
}
struct DataInfo: Codable {
    let userInfo: UserInfo
}
