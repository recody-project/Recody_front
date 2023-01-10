//
//  ListViewController.swift
//  Recody
//
//  Created by 마경미 on 15.12.22.
//

import UIKit
import SnapKit
class ListViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var listPageSuperView : UIView!
    var currentViewController = 0
    // 장르 배열 - api 필요
    let genres = ["1st","2nd","3rd","4th","5th","6th"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
    }
    
    func setGenre() {
        for genre in genres {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
            stackView.addArrangedSubview(button)
        }
        stackView.spacing = 0
    }
    
    func configurePageViewController() {
        // 여기 가드문에서 이미 팅겨져 나가고있었습니다.
        guard let pageViewController = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "listPageViewController") as? ListPageViewController else {
            return
        }
        pageViewController.setUpLayout(viewController: self,superView: listPageSuperView)
        let colors: [UIColor] = [UIColor.red,UIColor.blue,UIColor.green]
        for (index, genre) in genres.enumerated() {
            let viewController = UIViewController()
            viewController.view.backgroundColor = colors[index % 3]
            pageViewController.add(viewController: viewController).setUpLayout(viewController: self, superView: self.view)
        }
//        addChild(pageViewController) -> setUpLayout() 에서 이미 하고있는동작
        pageViewController.moveSlidePage()
        pageViewController.didMove(toParent: self)
    }
}
