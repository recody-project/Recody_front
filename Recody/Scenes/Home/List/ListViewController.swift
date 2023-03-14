//
//  ListViewController.swift
//  Recody
//
//  Created by 마경미 on 15.12.22.
//

import UIKit
import SnapKit

@available(iOS 14.0, *)
@available(iOS 14.0, *)
class ListViewController: CommonVC {
    @IBOutlet weak var listPageSuperView: UIView!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var genreScrollView: UIScrollView!
    @IBOutlet weak var genreStackView: UIStackView!
    var currentViewController = 0
    // 장르 배열 - api 필요
    let categories = [ Category(name: "전체", image: "전체"), Category(name: "책", image: "책"), Category(name: "영화", image: "영화"), Category(name: "드라마", image: "드라마"), Category(name: "음악", image: "음악"), Category(name: "공연", image: "공연") ]
    let genres = ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryStackView()
        setNavigationBar()
        setGenreStackView()
        configurePageViewController()
    }
    
    func setCategoryStackView() {
        for category in categories {
            let view = CustomCategory()
            view.setData(with: category)
            view.tag = 102
            view.widthAnchor.constraint(equalToConstant: 56).isActive = true
            categoryStackView.addArrangedSubview(view)
        }
        let view = CustomCategory()
        view.setDataForAdd()
        view.tag = 101
        view.widthAnchor.constraint(equalToConstant: 56).isActive = true
        categoryStackView.addArrangedSubview(view)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
    }
    
    func setNavigationBar() {
        let searchBar: UISearchBar = {
           let searchBar = UISearchBar()
            searchBar.placeholder = ""
            return searchBar
        }()
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setGenreStackView() {
        for genre in genres {
            let label: UILabel = {
                let label = UILabel()
                label.text = genre
                label.font = UIFont(name: "AppleSDGothicNeoM00-Regular", size: 14)
                label.textColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1)
                label.textAlignment = .center
                label.isUserInteractionEnabled = true
                label.tag = 104
                return label
            }()
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent(_:))))
            label.widthAnchor.constraint(equalToConstant: 101).isActive = true
            genreStackView.addArrangedSubview(label)
        }
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
        case setting = 100
        case pushAddCategory = 101
        case pushCategorySetting = 102
        case editButton = 103
        case moveIndicator = 104
        var number: Int {
            return self.rawValue
        }
    }
    
    override func display(orderNumber: Int) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
        case .pushAddCategory:
            router?.pushViewController(RoutingLogic.Navigation.categorySetting, dataStore: nil)
        case .moveIndicator:
            
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
        case .setting:
            if let data = dataStore?.data(useCase)?.fetch(UserDataModel.self) {
                let temp = data.data["signInInfo"] as? [String: String]
                guard let accessToken = temp?["accessToken"] else { return }
                guard let refreshToken = temp?["refreshToken"] else { return }
                KeyChain.create(key: "accessToken", token: accessToken)
                KeyChain.create(key: "refreshToken", token: refreshToken)
                print("요깅깅교익요긱")
                print(data)
            }
        default:
            self.presenter?.alertService.showToast("\(useCase)")
        }
    }
    
//    @IBAction func addCategory(sender: UIView) {
//        let index = categoryStackView.arrangedSubviews.count - 1
//        let addView = categoryStackView.arrangedSubviews[index]
//
//        let offset = CGPoint(x: categoryScrollView.contentOffset.x, y: categoryScrollView.contentOffset.y + addView.frame.size.width)
//        let newView = CustomCategory()
//        newView.isHidden = true
//        categoryStackView.insertArrangedSubview(newView, at: index)
//
//        UIView.animate(withDuration: 0.25, animations: {
//            newView.isHidden = false
//            self.categoryScrollView.contentOffset = offset
//        }, completion: nil)
//    }
    
    func configurePageViewController() {
        // 여기 가드문에서 이미 팅겨져 나가고있었습니다.
        guard let pageViewController = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "listPageViewController") as? ListPageViewController else {
            return
        }
        pageViewController.setUpLayout(viewController: self, superView: listPageSuperView)
        let colors: [UIColor] = [UIColor.red,UIColor.blue,UIColor.green]
        for (index, _) in genres.enumerated() {
            let viewController = UIViewController()
            viewController.view.backgroundColor = colors[index % 3]
//            pageViewController.add(viewController: viewController).setUpLayout(viewController: self, superView: self.view)
        }
//        addChild(pageViewController) -> setUpLayout() 에서 이미 하고있는동작
        pageViewController.moveSlidePage()
        pageViewController.didMove(toParent: self)
    }
}
