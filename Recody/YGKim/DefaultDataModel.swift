//
//  DefaultDataModel.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/24.
//

import Foundation

//최상위 슈퍼모델.Type
protocol DefaultDataModelType {
    var dic : Dictionary<String,Any> { get set }
    init(_ dic : Dictionary<String,Any>)
    func build(key : String, value:Any)
}
//최상위 슈퍼모델
class DefaultDataModel :DefaultDataModelType {
    
    var dic: Dictionary<String, Any>
    required init(_ dic:Dictionary<String,Any>){
        self.dic = dic
        
        if self.dic.count > 0 {
            self.dic.forEach({ element in
                build(key: element.key, value: element.value)
            })
        }
    }
    func build(key : String, value:Any){
        
    }
}

class ChildDataModel : DefaultDataModel {
    var id :String = ""
    
    override func build(key: String, value: Any) {
        if key == "id"{
            self.id = value as? String ?? ""
        }
        
    }
}


