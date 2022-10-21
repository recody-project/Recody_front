//
//  WorkerType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/21.
//

import Foundation

protocol WorkerDelegate {
    func completeWork( orderNumber : Int , reulst:Any)
}
protocol WorkerType {
    var delegate : WorkerDelegate? { get set }
    func recept(_ order : Int) -> Self
    func send(_ param : Dictionary<String,Any> )
    func send(_ param : Dictionary<String,Any>,_ header : Dictionary<String,Any>)
}

class SimpleWoker : WorkerType {
    var delegate : WorkerDelegate?
    var order : Int = -1
    func recept(_ order : Int) -> Self{
        self.order = order
        return self
    }
    
    func send(_ param : Dictionary<String, Any>) {
        // API 호출
        //완료후
        self.delegate?.completeWork(orderNumber: self.order, reulst: "")
    }
    
    func send(_ param : Dictionary<String, Any>, _ header: Dictionary<String, Any>) {
        // API 호출
        //완료후
        self.delegate?.completeWork(orderNumber: self.order, reulst: "")
    }
}
