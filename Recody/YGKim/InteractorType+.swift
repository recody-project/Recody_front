//
//  InteractorType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/21.
//

import Foundation
import UIKit
protocol PresneterType {
        
}
// Interactor는 무조건 just 함수로 커맨드를 받음
protocol InteractorType : WorkerDelegate {
    init(_ worker : WorkerType)
    func just(_ orderNumber : OrderType) -> WorkerType
}
//Worker -> 서비스를 들고있다 Api, 로딩 등등
//

enum SomeOrder : OrderType {
    case new
    var number: Int {
        switch self {
            case .new: return 100
        }
    }
}
// 화면별로 정의
protocol BusinessLogicType {
    associatedtype Order : OrderType
//    associatedtype ViewModel : ViewModelType
    associatedtype DataStore : DataStoreType
}

protocol OrderType {
    var number : Int { get }
}

protocol ViewModel {
    
}
protocol DataStoreType {
    var data : Any { get }
}

class TestInteractor : InteractorType {
    var worker : WorkerType
    required init(_ worker: WorkerType) {
        self.worker = worker
        self.worker.delegate = self
    }
    func just(_ orderNumber : OrderType) -> WorkerType{
        return self.worker.recept(orderNumber.number)
    }
    
    func completeWork(orderNumber: Int, reulst: Any) {
        
    }
}
//
//let interactor1 = TestInteractor(SimpleWoker())
//func t(){
//    interactor1.just(SomeOrder.new).send(["A" : ""])
//}
