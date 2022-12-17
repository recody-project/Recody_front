//
//  ListViewController.swift
//  Recody
//
//  Created by 마경미 on 15.12.22.
//

import UIKit
import Foundation

class ListPageViewController : UIPageViewController {
    var dataViewControllers = [UIViewController]()
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
    
    func add(viewControllers: [UIViewController]) -> Self {
        for (vc) in viewControllers.enumerated() {
            dataViewControllers.append(vc.element)
        }
        self.reloadInputViews()
        return self
    }

    func add(viewController: UIViewController) -> Self {
        dataViewControllers.append(viewController)
        self.reloadInputViews()
        return self
    }
    
    func initViewController(viewController: UIViewController) {
        
    }

    // default First
    func moveSlidePage(index : Int = 0){
        if index == 0 {
            if let moveVC = dataViewControllers.first {
                self.setViewControllers([moveVC], direction: .forward, animated: true, completion: nil)
            }
        } else {
            if index < dataViewControllers.count {
                let moveVC = dataViewControllers[index]
                self.setViewControllers([moveVC], direction: .forward, animated: true, completion: nil)
            } else {
                fatalError("SlideContentViewController index out of range / index : \(index) / dataViewControllers.count : \(dataViewControllers.count)")
            }
            
        }
        
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

extension ListPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        } else {
            return dataViewControllers[previousIndex]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex >= dataViewControllers.count {
            return nil
        } else {
            return dataViewControllers[nextIndex]
        }
    }
 
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//
//        if completed {
//            previousPage = previousViewControllers[0]
//            realNextPage = nextPage
//            print(realNextPage)
//            if realNextPage is Mongle.OnboardingFirstVC {
//                self.keyValue.curPresentViewIndex = 0
//                onboardingDelegate?.toNextPage(next: 0)
//            }
//            else if realNextPage is Mongle.OnboardingSecondVC{
//                self.keyValue.curPresentViewIndex = 1
//                onboardingDelegate?.toNextPage(next: 1)
//            }
//            else if realNextPage is Mongle.OnboardingThirdVC{
//                self.keyValue.curPresentViewIndex = 2
//                onboardingDelegate?.toNextPage(next: 2)
//            }
//            else{
//                self.keyValue.curPresentViewIndex = 3
//                onboardingDelegate?.toNextPage(next: 3)
//            }
//        }
//    }
}

//MARK: - 사용법

//class SomeViewController : UIViewController {
//
//    lazy var pageVC: PageViewController = {
//          let vc = PageViewController()
//          return vc
//      }()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let vcs = (0...2).map({ index -> UIViewController in
//            let vc = UIViewController()
//            vc.view.backgroundColor = .white
//            let label = UILabel()
//            label.text = "\(index)"
//            label.textColor = .black
//            vc.view.addSubview(label)
//            vc.view.bringSubviewToFront(label)
//            label.snp.makeConstraints({
//                $0.edges.centerX.centerY.equalToSuperview()
//            })
//            return vc
//        })
//
//        pageVC.add(viewControlers: vcs)
//            .setUpLayout(viewController: self, superView: self.view)
//              .moveSlidePage()
//    }
//
//}


