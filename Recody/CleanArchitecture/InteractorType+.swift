//
//  InteractorType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/21.
//

import Foundation
import UIKit
// Interactor는 무조건 just 함수로 커맨드를 받음
protocol InteractorType: WorkerDelegate {
    init(_ worker: WorkerType, presenter: PresenterType)
    func just(_ orderNumber: OrderType) -> WorkerType
    var presenter: PresenterType { get set }
}
// Worker -> 서비스를 들고있다 Api, 로딩 등등
//

enum SomeOrder: OrderType {
    case new
    var number: Int {
        switch self {
        case .new: return 100
        }
    }
}
// 화면별로 정의
protocol BusinessLogicType {
    associatedtype Order: OrderType
//    associatedtype ViewModel : ViewModelType
    associatedtype DataStore: DataStoreType
}

protocol OrderType {
    var number: Int { get }
}

protocol DataStoreType {
    var dataStoreArr: [Int: WorkResult] { get set }
    func data(_ order: OrderType) -> WorkResult?
}

class SimpleInteractor: InteractorType, DataStoreType {
    
    var presenter: PresenterType
    var worker: WorkerType

    required init(_ worker: WorkerType, presenter: PresenterType) {
        self.worker = worker
        self.presenter = presenter
        self.worker.delegate = self
    }
    func just(_ orderNumber: OrderType) -> WorkerType {
        return self.worker.recept(orderNumber.number)
    }

    var dataStoreArr: [Int: WorkResult] = [Int: WorkResult]()
    private func checkData(_ order: OrderType) -> Bool {
          return self.dataStoreArr.contains(where: {$0.key == order.number})
    }

    func data(_ order: OrderType) -> WorkResult? {
          if self.checkData(order) {
              return self.dataStoreArr[order.number]
          }
          return nil
    }

    func complete(orderNumber: Int, result: WorkResult) {
        if result.obj != nil {
            self.dataStoreArr[orderNumber] = result
            // Presenter에게 알리기 -> orderNumber ,DataStoreType
            self.presenter.responseSuccess(orderNumber: orderNumber, dataStore: self)
        } else {
            self.presenter.responseSuccess(orderNumber: orderNumber, dataStore: nil)
        }
    }
    func failed(orderNumber: Int, msg: String?) {
        self.presenter.responseErorr(orderNumber: orderNumber,msg:msg)
    }
    func drop(orderNumber: Int) {
        self.presenter.drop(orderNumber: orderNumber)
    }
}
