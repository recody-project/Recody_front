//
//  AddRecordViewController.swift
//  Recody
//
//  Created by 마경미 on 19.03.23.
//

import UIKit

class AddRecordViewController: CommonVC {
//    var viewModel = AddRecordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
    }
    
    @objc func clickEvent(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            guard let useCase = UseCase(rawValue: tag) else { return }
            switch useCase {
            default:
                self.interactor?.just(useCase).drop()
            }
        }
    }
    
    enum UseCase: Int, OrderType {
//        case pushRecordList = 100
//        case setting = 105
//        case notification = 106
//        case moveReviewing = 107
//        case workCategory = 108
        case pushWorkDetailInfo = 109
        var number: Int {
            return self.rawValue
        }
    }
    
    override func display(orderNumber: Int) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
        default:
            break
        }
    }
    
    override func displayErorr(orderNumber: Int, msg: String?) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
        default:
            self.presenter?.alertService.showToast("\(useCase)")
        }
    }
    
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
        default:
            self.presenter?.alertService.showToast("\(useCase)")
        }
    }
}
