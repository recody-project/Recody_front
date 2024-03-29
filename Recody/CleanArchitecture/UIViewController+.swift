//
//  UIViewController+.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/17.
//
import Foundation
import UIKit

//protocol CommonVCType {
//    var interactor: InteractorType? { get }
//    var presenter: PresenterType? { get }
//    var router: RouterType? { get }
//}
//class CommonVC: UIViewController, CommonVCType, PresentationLogicType {
//    func displayErorr(orderNumber: Int, msg: String?) {
//    }
//    func display(orderNumber: Int) {
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
//    }
//}
//
//extension CommonVC {
//    var interactor: InteractorType? {
//        get { DependencyContainer.shared.bindInteractor(viewController: self) }
//    }
//    var presenter: PresenterType? {
//        get { DependencyContainer.shared.bindPresenter(viewController: self) }
//    }
//    var router: RouterType? {
//        get { DependencyContainer.shared.bindRouter(viewController: self) }
//    }
//}
//
//extension CommonVC {
//    static var name: String { String(describing: Self.self) }
//    var name: String { String(describing: Self.self) }
//    static func swizzleMethod() {
//        let originalSelector = #selector(viewDidLoad)
//        let swizzleSelector = #selector(swizzleViewDidLoad)
//        guard
//            let originMethod = class_getInstanceMethod(UIViewController.self, originalSelector),
//            let swizzleMethod = class_getInstanceMethod(CommonVC.self, swizzleSelector)
//        else { return }
//        method_exchangeImplementations(originMethod, swizzleMethod)
//    }
//    @objc public func swizzleViewDidLoad() {
//        let router = SimpleRouter(context: self)
//        let presenter = SimplePresenter(context: self)
//        presenter.delegate = self
//        let worker = SimpleWoker()
//        let interactor = SimpleInteractor(worker, presenter: presenter)
//        DependencyContainer.shared.ready(viewController: self, interactor: interactor, router: router, presenter: presenter)
//    }
//}
