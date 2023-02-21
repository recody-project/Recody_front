//
//  PageViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/12/13.
//

import Foundation
import UIKit
class PageViewController: UIPageViewController {
    
    var dataViewControllers = [UIViewController]()
//    var delegate: PageViewControllerDelegate?
    var lastIndex = 0
    
    //필수 호출
    //viewController : 부모 뷰컨트롤러
    //superView : 이 VC 가 들어갈 View
    func setUpLayout(viewController : UIViewController,
                     superView : UIView? = nil) -> Self{
        viewController.addChild(self)
        if superView != nil {
            superView?.addSubview(self.view)
        } else {
            viewController.view.addSubview(self.view)
        }
        
        self.view.snp.makeConstraints({ make in
            make.top.bottom.right.left.equalToSuperview()
        })
        self.didMove(toParent: self)
        
        return self
    }
    
    func add(viewControlers : [UIViewController]) -> Self{
        for (vc) in viewControlers.enumerated() {
            dataViewControllers.append(vc.element)
        }
        self.reloadInputViews()
        return self
    }
    func add(viewControler : UIViewController) -> Self{
        dataViewControllers.append(viewControler)
        self.reloadInputViews()
        return self
    }
    // default First
    func moveSlidePage(index : Int = 0){
            
        if index < dataViewControllers.count {
            if index > lastIndex {
                let moveVC = dataViewControllers[index]
                self.setViewControllers([moveVC], direction: .forward, animated: true, completion: nil)
            }else {
                let moveVC = dataViewControllers[index]
                self.setViewControllers([moveVC], direction: .reverse, animated: true, completion: nil)
            }
        } else {
            fatalError("SlideContentViewController index out of range / index : \(index) / dataViewControllers.count : \(dataViewControllers.count)")
        }
    
        lastIndex = index
    }
    
    func reloadData(){
        self.delegate = nil
        self.dataSource = nil
        self.delegate = self
        self.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    convenience init(){
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
}
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
//        if let vc = dataViewControllers[previousIndex] as? HomeSlideViewController {
//            vc.view.snp.removeConstraints()
//            vc.setUpLayout(viewController: self, superView: self.view)
//                .moveSlidePage()
//        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        
//        if let vc = dataViewControllers[nextIndex] as? FindmeSlideViewController {
//            if vc.view.tag == 4 {
//                vc.view.snp.removeConstraints()
//                vc.setUpLayout(viewController: self, superView: self.view)
//                    .moveSlidePage()
//            }
//        }
        
        return dataViewControllers[nextIndex]
    }
}

//MARK: - 사용법

class SomeViewController : UIViewController {
    
    lazy var pageVC: PageViewController = {
          let vc = PageViewController()
          return vc
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let vcs = (0...2).map({ index -> UIViewController in
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            let label = UILabel()
            label.text = "\(index)"
            label.textColor = .black
            vc.view.addSubview(label)
            vc.view.bringSubviewToFront(label)
            label.snp.makeConstraints({
                $0.edges.centerX.centerY.equalToSuperview()
            })
            return vc
        })
        
        pageVC.add(viewControlers: vcs)
            .setUpLayout(viewController: self, superView: self.view)
              .moveSlidePage()
    }
    
}

