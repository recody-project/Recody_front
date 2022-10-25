//
//  PresenterType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/25.
//

import Foundation
protocol PresentationLogicType {
    func displaySuccess( orderNumber : Int, dataStore : DataStoreType? )
    func displayErorr( orderNumber : Int )
}
protocol PresenterType {
    var delegate : PresentationLogicType? { get set }
    func responseSuccess( orderNumber : Int, dataStore : DataStoreType? )
    func responseErorr( orderNumber : Int )
}

class SimplePresenter : PresenterType {
    var delegate: PresentationLogicType?
    
    func responseSuccess(orderNumber: Int, dataStore: DataStoreType?) {
        self.delegate?.displaySuccess(orderNumber: orderNumber, dataStore: dataStore)
    }
    
    func responseErorr(orderNumber: Int) {
        self.delegate?.displayErorr(orderNumber: orderNumber)
    }
    
    
}
