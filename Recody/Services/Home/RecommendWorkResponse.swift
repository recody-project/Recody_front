//
//  RecommendWorkResponse.swift
//  Recody
//
//  Created by 마경미 on 17.08.23.
//

import Foundation

struct RecommendWorkResponse: Codable {
    let message: String
    let data: RecommendWorkData
}
struct RecommendWorkData: Codable {
    let record: RecommendWork
}
struct RecommendWork: Codable {
    let recordId: String
    let userId: Int
    let contentId: String
    let title: String
    let note: String
    let completed: Bool
}
