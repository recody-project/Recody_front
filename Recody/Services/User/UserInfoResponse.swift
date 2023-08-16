//
//  UserInfoResponse.swift
//  Recody
//
//  Created by 마경미 on 16.08.23.
//

import Foundation

struct UserInfoResponse: Codable {
    let message: String
    let data: UserInfoData
}
struct UserInfoData: Codable {
    let userInfo: UserInfo
}
struct UserInfo: Codable {
    let userId: Int
    let email: String
    let name: String?
    let socialType: String
    let nickname: String
    let role: String
    let pictureUrl: String?
}
