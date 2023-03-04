//
//  WorkerType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/21.
//

import Foundation

protocol WorkerDelegate {
    func drop( orderNumber: Int)
    func complete( orderNumber: Int, result: WorkResult)
    func failed( orderNumber: Int, msg: String?)
}
protocol WorkerType {
    var delegate: WorkerDelegate? { get set }
    func recept(_ order: Int) -> Self
    func drop()
    func api(_ command: ApiCommand )
}

class SimpleWoker: WorkerType {
    var delegate: WorkerDelegate?
    var order: Int = -1
    func recept(_ order: Int) -> Self {
        self.order = order
        return self
    }

    func api(_ command: ApiCommand ) {
        ApiClient.request(command: command, { result in
            self.delegate?.complete(orderNumber: self.order, result: result)
        }, { msg in
            self.delegate?.failed(orderNumber: self.order, msg: msg)
        })
    }
    func drop() {
        self.delegate?.drop(orderNumber: self.order)
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

class UserDataModel: DefaultDataModel {
    
    var message: String = ""
    var data = [String: Any]()
    override func build(key: String, value: Any) {
        if key == "message"{
            self.message = stringValue(value)
        }
        if key == "data" {
            if let temp = value as? [String: Any] {
                self.data = temp
            }
        }
    }
//    var userId: String = ""
//    var email: String = ""
//    var name: String = ""
//    var socialType: String = ""
//    var nickname: String = ""
//    var role: String = ""
//    var pictureUrl: String = ""
//    override func build(key: String, value: Any) {
//        if key == "userId" {
//            userId = value
//        } else if key == "email" {
//            email = value
//        } else if key == "name" {
//            name = value
//        } else if key == "socialType" {
//            socialType = value
//        } else if key == "role" {
//            role = value
//        } else if key == "pictureUrl" {
//            pictureUrl = value
//        } else {
//            print("해당하는 key가 존재하지 않습니다")
//        }
//    }
}
