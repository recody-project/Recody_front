//
//  MySearchViewController.swift
//  Recody
//
//  Created by 마경미 on 12.10.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MySearchDisplayLogic: class {
    func displaySomething(viewModel: MySearch.API.ViewModel)
}

class MySearchViewController: UIViewController, MySearchDisplayLogic {
    var interactor: MySearchBusinessLogic?
    var router: (NSObjectProtocol & MySearchRoutingLogic & MySearchDataPassing)?

    var mySearchs: [String] = [
        "블랙핑크", "블랙팬서", "미움 받을 용기", "닥터스트레인지"
    ]
    var filteredData: [String]!

    // MARK: Object lifecycle

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
        let interactor = MySearchInteractor()
        let presenter = MySearchPresenter()
        let router = MySearchRouter()
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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var genreView: UIView!

    func doSomething() {
        let request = MySearch.API.Request()
        interactor?.doSomething(request: request)

        registerTableViewCells()
        filteredData = mySearchs
    }

    func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "MySearchTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "mySearchTableViewCell")
    }
    
    func removeCell() {
        
    }

    func displaySomething(viewModel: MySearch.API.ViewModel) {
        // nameTextField.text = viewModel.name
    }
}
