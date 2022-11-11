//
//  WorkDetailInfoViewController.swift
//  Recody
//
//  Created by 마경미 on 2022/08/23.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WorkDetailInfoDisplayLogic: AnyObject {
    func displaySomething(viewModel: WorkDetailInfo.API.ViewModel)
}

class WorkDetailInfoViewController: UIViewController, WorkDetailInfoDisplayLogic {
    var interactor: WorkDetailInfoBusinessLogic?
    var router: (NSObjectProtocol & WorkDetailInfoRoutingLogic & WorkDetailInfoDataPassing)?
    // MARK: Object lifecycle
    let works: [Work] = [
        Work(id: "1", name: "WANDAVISION", image: "wanda"),
        Work(id: "2", name: "NOWAYHOME", image: "spiderman")
    ]

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = WorkDetailInfoInteractor()
        let presenter = WorkDetailInfoPresenter()
        let router = WorkDetailInfoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    // MARK: Do something

    // @IBOutlet weak var nameTextField: UITextField!

    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func doSomething() {
        let request = WorkDetailInfo.API.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: WorkDetailInfo.API.ViewModel) {
        // nameTextField.text = viewModel.name
    }
}
