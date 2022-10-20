//
//  ProtocolEx6.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/20.
//

import Foundation

// associatedtype 맛보기
// associatedtype 따로 타입을 지금 정하지않고 나중에정하겠다는 의미
protocol P6 {
    associatedtype Request
    associatedtype Response
    associatedtype ViewModel
}

enum P6Enum : P6 {
    struct Request {
        
    }
    struct Response {
        
    }
    struct ViewModel {
        
    }
}

protocol P61 {
    associatedtype View : P6
    func justDo(v : View.Request) -> View.Response
}


