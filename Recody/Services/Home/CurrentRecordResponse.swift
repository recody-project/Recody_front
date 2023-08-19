//
//  CurrentRecordResponse.swift
//  Recody
//
//  Created by 마경미 on 17.08.23.
//

import Foundation

struct CurrentRecordResponse: Codable {
    let message: String
    let data: CurrentRecordData
}
struct CurrentRecordData: Codable {
    let record: CurrentRecord
}
struct CurrentRecord: Codable {
    let recordId: String
    let contentId: String
    let imageUrl: String
    let title: String
    let appreciationDate: String
    let lastModifiedAt: String
}
