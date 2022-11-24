//
//  DepencencyContainer.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/17.
//

import Foundation
import UIKit
// 의종성 주입 클래스
class DependencyContainer {
    static let shared = DependencyContainer()

    private var vcArr = [String: [Any]]()

    func ready<T: CommonVC> (viewController: T, interactor: InteractorType, router: SimpleRouter, presenter: PresenterType) {
        let name = viewController.name
        if vcArr.contains(where: {$0.key == name}) {
            unbind(name)
        }
        vcArr[name] = [interactor,
                       router,
                       presenter]
        print("DependencyContainer.ready() :: \(viewController.name) , memory addr: \(viewController)")
    }
    private func checkArr<T: CommonVC >(viewController: T)->[Any]? {
        if let itemArr = self.vcArr[viewController.name] {
            if itemArr.count == 3 {
                return itemArr
            }
        }
        return nil
    }
    func bindInteractor<T: CommonVC>(viewController: T) -> InteractorType? {
        if let itemArr = self.checkArr(viewController: viewController) {
            if let item = itemArr.filter({ $0 is InteractorType }).first as? InteractorType {
                return item
            }
        }
        return nil
    }
    func bindRouter<T: CommonVC>(viewController: T) -> SimpleRouter? {
        if let itemArr = self.checkArr(viewController: viewController) {
            if let item = itemArr.filter({ $0 is SimpleRouter }).first as? SimpleRouter {
                return item
            }
        }
        return nil
    }
    func bindPresenter<T: CommonVC>(viewController: T) -> PresenterType? {
        if let itemArr = self.checkArr(viewController: viewController) {
            if let item = itemArr.filter({ $0 is PresenterType }).first as? PresenterType {
                return item
            }
        }
        return nil
    }
    func unbind(_ vcName: String) {
        if vcArr.contains(where: {$0.key == vcName}) {
           vcArr.removeValue(forKey: vcName)
        }
    }
}
