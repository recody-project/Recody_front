//
//  ListViewController.swift
//  Recody
//
//  Created by 마경미 on 15.12.22.
//

import UIKit
import SnapKit
import Foundation

class ListPageViewController: UIPageViewController {
    var dataViewControllers = [UIViewController]()
    var lastIndex = 0
    
    func setUpLayout(viewController: UIViewController,
                     superView: UIView? = nil) -> Self {
        viewController.addChild(self)
        if superView != nil {
            superView?.addSubview(self.view)
        } else {
            viewController.view.addSubview(self.view)
        }
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        let nib = UINib(nibName: "WorkListCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: "workListCollectionView")
////        collectionView.register(WorkListCollectionViewCell.self, forCellWithReuseIdentifier: "workListCollectionView")
//        viewController.view.addSubview(collectionView)
//
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        self.didMove(toParent: self)
        
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

    // default First
    func moveSlidePage(index: Int = 0) {
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

    func reloadData() {
        delegate = nil
        dataSource = nil
        delegate = self
        dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        
        
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        self.add(viewController: vc)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "WorkListCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "workListCollectionView")
        collectionView.register(WorkListCollectionViewCell.self, forCellWithReuseIdentifier: "workListCollectionView")
        vc.view.addSubview(collectionView)
        collectionView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        self.didMove(toParent: self)
                
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    convenience init() {
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataViewControllers.count
    }
}

extension ListPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // genre수만큼
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workListCollectionView", for: indexPath) as? WorkListCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 164)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if #available(iOS 14.0, *) {
            let vc = ListViewController()
            if scrollView.contentOffset.y <= 0 {
                vc.foldView(false)
            } else {
                vc.foldView(true)
            }
        } else {
            print("14.0 이상만 가능합니다.")
        }
    }
}
