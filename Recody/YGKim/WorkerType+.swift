//
//  WorkerType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/21.
//

import Foundation

protocol WorkerDelegate {
    func completeWork( orderNumber : Int , reulst:WorkResult)
}
protocol WorkerType {
    var delegate : WorkerDelegate? { get set }
    func recept(_ order : Int) -> Self
    func send(_ param : Dictionary<String,String> )
    func send(_ param : Dictionary<String,String>,_ header : Dictionary<String,String>)
}

class SimpleWoker : WorkerType {
    
    var delegate : WorkerDelegate?
    var order : Int = -1
    func recept(_ order : Int) -> Self{
        self.order = order
        return self
    }
    
    func send(_ param : Dictionary<String, String>) {
        // API 호출
        
        //완료후
        var data : Dictionary<String,Any>?
        if let dic = data {
            self.delegate?.completeWork(orderNumber: self.order, reulst: WorkResult(result: true,obj: dic))
        }
        self.delegate?.completeWork(orderNumber: self.order, reulst: WorkResult(result: false))
    }
    
    func send(_ param : Dictionary<String, String>, _ header: Dictionary<String, String>) {
        // API 호출
        //완료후
        var data : Dictionary<String,Any>?
        if let dic = data {
            self.delegate?.completeWork(orderNumber: self.order, reulst: WorkResult(result: true,obj: dic))
        }
        self.delegate?.completeWork(orderNumber: self.order, reulst: WorkResult(result: false))
        
    }
}

struct WorkResult {
    var result : Bool
    var obj : Dictionary<String,Any>?
    init(result: Bool, obj: Dictionary<String,Any>? = nil) {
        self.result = result
        self.obj = obj
    }
//    DefaultDataModelType을 다운 캐스팅 하기위한 제네릭함수
    func fetch<T : DefaultDataModelType>(_ type : T.Type) -> T? {
        
        if let obj = self.obj {
            return T(obj)
        }
        return nil
    }
}

