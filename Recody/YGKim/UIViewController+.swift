//
//  UIViewController+.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/17.
//

import Foundation
import UIKit

protocol CommonVC {
    associatedtype Interactor
    associatedtype Presenter
    var interactor : Interactor { get set }
    var presneter : Presenter { get set }
    var router : SimpleRouter { get set }
}
extension UIViewController {
    var name : String { String(describing: Self.self) }
}

//private func setup() {
//    let viewController = self
//    let interactor = HomeInteractor()
//    let presenter = HomePresenter()
//    let router = HomeRouter()
//    viewController.interactor = interactor
//    viewController.router = router
//    interactor.presenter = presenter
//    presenter.viewController = viewController
//    router.viewController = viewController
//    router.dataStore = interactor
//}
extension UIViewController {
    class func swizzleMethod() {
        let originalSelector = #selector(viewDidLoad)
        let swizzleSelector = #selector(swizzleViewDidLoad)
        guard
            let originMethod = class_getInstanceMethod(UIViewController.self, originalSelector),
            let swizzleMethod = class_getInstanceMethod(UIViewController.self, swizzleSelector)
        else { return }
        method_exchangeImplementations(originMethod, swizzleMethod)
    }
    @objc public func swizzleViewDidLoad() {
        
//        if !(self is UIViewController & any CommonVC) { return }
         
//        if self is any TestViewController & CommonVC {
//            (self as! TestViewController & any CommonVC).interactor = HomeInteractor()
//            (self as! TestViewController & any CommonVC).presneter = HomePresenter()
//            (self as! TestViewController & any CommonVC).router = HomeRouter()
//        }
    }
}

