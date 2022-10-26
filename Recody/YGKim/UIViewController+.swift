//
//  UIViewController+.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/17.
//
import Foundation
import UIKit

protocol CommonVCType {
    var interactor: InteractorType? { get }
    var presenter: PresenterType? { get }
    var router: RouterType? { get }
}

class SomeVC: CommonVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {

    }
    override func displayErorr(orderNumber: Int) {

    }
}

class CommonVC: UIViewController, CommonVCType, PresentationLogicType {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {

    }
    func displayErorr(orderNumber: Int) {

    }
}

extension CommonVC {
    var interactor: InteractorType? {
        get {
            return DependencyContainer.shared.bindInteractor(viewController: self)
        }
    }
    var presenter: PresenterType? {
        get {
            return DependencyContainer.shared.bindPresenter(viewController: self)
        }
    }
    var router: RouterType? {
        get {
            return DependencyContainer.shared.bindRouter(viewController: self)
        }
    }
}

extension CommonVC {
    static var name: String { String(describing: Self.self) }
    var name: String { String(describing: Self.self) }
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
        let router = SimpleRouter(context: self)
        let presenter = SimplePresenter()
        presenter.delegate = self
        let worker = SimpleWoker()
        let interactor = SimpleInteractor(worker, presenter: presenter)
        DependencyContainer.shared.ready(viewController: self, interactor: interactor, router: router, presenter: presenter)
    }
}
