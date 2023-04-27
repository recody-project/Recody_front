//
//  EditGenreViewController.swift
//  Recody
//
//  Created by 마경미 on 2022/09/05.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EditGenreDisplayLogic: AnyObject {
    func displaySomething(viewModel: EditGenre.Something.ViewModel)
}

class EditGenreViewController: UIViewController, EditGenreDisplayLogic {
    var interactor: EditGenreBusinessLogic?
    var router: (NSObjectProtocol & EditGenreRoutingLogic & EditGenreDataPassing)?
    var genres = [ "로맨스 코미디", "스릴러", "액션", "범죄", "SF", "코미디", "공포", "전쟁",
                   "스포츠", "판타지", "음악", "뮤지컬", "장르", "장르", "장르", "장르", "장르", "장르", "장르", "장르"]
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
        let interactor = EditGenreInteractor()
        let presenter = EditGenrePresenter()
        let router = EditGenreRouter()
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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var category: CustomCategory!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    static func getInstanse() -> EditGenreViewController{
        guard let vc =  UIStoryboard(name: "CategorySetting", bundle: nil).instantiateViewController(withIdentifier: "CategorySetting") as? EditGenreViewController
        else {
            fatalError()
        }
        return vc
    }
    // MARK: Do something
    func doSomething() {
        let request = EditGenre.Something.Request()
        interactor?.doSomething(request: request)
        viewHeight.constant = CGFloat(250 + 56 * genres.count / 2)
        category.toggleEditButtonHidden()
    }

    func displaySomething(viewModel: EditGenre.Something.ViewModel) {
        // nameTextField.text = viewModel.name
    }
}
