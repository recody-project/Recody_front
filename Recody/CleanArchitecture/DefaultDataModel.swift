//
//  DefaultDataModel.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/24.
//

import Foundation

// 최상위 슈퍼모델.Type
protocol DefaultDataModelType {
    var dic: [String: Any] { get set }
    init(_ dic: [String: Any])
    func build(key: String, value: Any)
}
// 최상위 슈퍼모델
class DefaultDataModel: DefaultDataModelType {
    var dic: [String: Any]
    required init(_ dic: [String: Any]) {
        self.dic = dic

        if self.dic.count > 0 {
            self.dic.forEach({ element in
                build(key: element.key, value: element.value)
            })
        }
    }
    func stringValue(_ value:Any ) -> String{
        return value as? String ?? ""
    }
    func intValue(_ value:Any ) -> Int{
        return value as? Int ?? 0
    }
    func doubleValue(_ value:Any ) -> Double{
        return value as? Double ?? 0.0
    }
    func build(key: String, value: Any) {

    }
}

class ChildDataModel: DefaultDataModel {
    var message:String = ""
    var data = Dictionary<String,Any>()
    override func build(key: String, value: Any) {
        if key == "message"{
            self.message = stringValue(value)
        }
        if key == "data" {
            if let temp = value as? Dictionary<String,Any> {
                self.data = temp
            }
        }
    }
}
