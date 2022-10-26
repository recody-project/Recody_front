//
//  WorkerType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/21.
//

import Foundation

protocol WorkerDelegate {
    func complete( orderNumber: Int, result: WorkResult)
    func failed( orderNumber: Int)
}
protocol WorkerType {
    var delegate: WorkerDelegate? { get set }
    func recept(_ order: Int) -> Self
    func send(_ param: [String: String] )
    func send(_ param: [String: String], _ header: [String: String])
}

class SimpleWoker: WorkerType {
    var delegate: WorkerDelegate?
    var order: Int = -1
    func recept(_ order: Int) -> Self {
        self.order = order
        return self
    }

    func send(_ param: [String: String]) {
        // API 호출
        // 완료후
        var data: [String: Any]?
        if let dic = data {
            self.delegate?.complete(orderNumber: self.order, result: WorkResult(dic))
        }
        self.delegate?.failed(orderNumber: self.order)
    }

    func send(_ param: [String: String], _ header: [String: String]) {
        // API 호출
        // 완료후
        var data: [String: Any]?
        if let dic = data {
            self.delegate?.complete(orderNumber: self.order, result: WorkResult(dic))
        }
        self.delegate?.failed(orderNumber: self.order)
    }
}

struct WorkResult {
    var obj: [String: Any]?
    init(_ obj: [String: Any]? = nil) {
        self.obj = obj
    }
//    DefaultDataModelType을 다운 캐스팅 하기위한 제네릭함수
    func fetch<T: DefaultDataModelType>(_ type: T.Type) -> T? {
        if let obj = self.obj {
            return T(obj)
        }
        return nil
    }
}
