//
//  PresenterType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/25.
//

import Foundation
import UIKit
protocol PresentationLogicType {
    func displaySuccess( orderNumber: Int, dataStore: DataStoreType? )
    func displayErorr( orderNumber: Int,msg:String?)
    func display( orderNumber: Int)
}
protocol PresenterType {
    var delegate: PresentationLogicType? { get set }
    func responseSuccess( orderNumber: Int, dataStore: DataStoreType? )
    func responseErorr(orderNumber: Int,msg:String?)
    func drop( orderNumber:Int )
    var alertService : AlertServiceType { get }
    init(context: UIViewController)
}

class SimplePresenter: PresenterType {
    var alertService: AlertServiceType
    
    required init(context: UIViewController) {
        self.alertService = AlertService(context)
    }
    var delegate: PresentationLogicType?

    func responseSuccess(orderNumber: Int, dataStore: DataStoreType?) {
        self.delegate?.displaySuccess(orderNumber: orderNumber, dataStore: dataStore)
    }

    func responseErorr(orderNumber: Int,msg:String?) {
        self.delegate?.displayErorr(orderNumber: orderNumber,msg: msg)
    }
    func drop(orderNumber: Int) {
        self.delegate?.display(orderNumber: orderNumber)
    }
}
