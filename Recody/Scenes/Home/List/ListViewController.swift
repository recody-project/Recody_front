//
//  ListViewController.swift
//  Recody
//
//  Created by 마경미 on 15.12.22.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
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
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: "listPageViewController") as? ListPageViewController else {
            return
        }
        
        for genre in genres {
            let viewController = UIViewController()
            pageViewController.add(viewController: viewController).setUpLayout(viewController: self, superView: self.view).moveSlidePage()
        }
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }
}
