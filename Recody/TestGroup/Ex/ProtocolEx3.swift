//
//  ProtocolEx3.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/20.
//

import Foundation

protocol P3 {
    mutating func toggle()
}

enum P3Switch: P3 {
    case off,on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

//var switchItem = P3Switch.on
//switchItem.toggle()



