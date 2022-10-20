//
//  ProtocolEx4.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/20.
//

import Foundation

//MARK: - 이니셜라이져 강제

protocol P4 {
    init(value: Int)
}
class P4Class : P4 {
    required init(value: Int) {

    }
}

let p4 = P4Class(value: 1)
