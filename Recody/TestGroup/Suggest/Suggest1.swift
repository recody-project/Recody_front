//
//  Suggest1.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/20.
//

import Foundation

class Suggest1Super {
    var dic : Dictionary<String,Any>
    init(_ dic : Dictionary<String,Any>){
        self.dic = dic
    }
    func setup(){
        
    }
}

class Suggest1Child : Suggest1Super {
    // 특별한 속성의 변수들 추가
    override func setup() {
        self.dic
        // just do some
        // 원본 데이터에서 할당
    }
    
}
