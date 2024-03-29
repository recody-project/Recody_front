//
//  RouterType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/19.
//
import Foundation
import UIKit
//
//protocol RouterType {
//    init(context: UIViewController)
//    var context: UIViewController { get }
//    func present(_ navigation: NavigationType, _ dataStore: DataStoreType?)
//    func present(_ navigation: NavigationType, _ dataStore: DataStoreType?, _ presentModalStyle: UIModalPresentationStyle?)  // UIViewController 에서 직접 Present
//    func presentWithRootViewcontroller(_ navigation: NavigationType, _ dataStore: DataStoreType?, _ presentModalStyle: UIModalPresentationStyle?)  // UIViewController 에서 직접 Present
//    func perform(_ segment: SegmentType, _ dataStore: DataStoreType?) // 세그먼트를 이용한 화면이동
//    func pushViewController(_ navigation: NavigationType, dataStore: DataStoreType?) // UINavigationController
//    func popViewContoller(animated: Bool)
//    func tabbarMovePreviousPage(_ index:Int?) // 호출 VC의 상위스택에 탭바가 존재해야함 index = nil 이전페이지 이동 / index 번쨰 Tab으로 이동
//}
//
//protocol DataPassingType {
//    func bind(_ data: DataStoreType)
//}
//
//protocol NavigationType {
//    var viewcontroller: UIViewController? { get }
//}
//protocol SegmentType {
//    var segue: UIStoryboardSegue? { get }
//}
//protocol RoutingLogicType {
//    associatedtype Navigation: NavigationType
//    associatedtype Segment: SegmentType
//}
//
//class SimpleRouter: RouterType {
//    
//    var context: UIViewController
//
//    required init(context: UIViewController) {
//        self.context = context
//    }
//    func present(_ navigation: NavigationType, _ dataStore: DataStoreType?) {
//        if check(navigation) {
//            let next = navigation.viewcontroller!
//            if let data = dataStore {
//                (next as? DataPassingType)?.bind(data)
//            }
//            context.present(next, animated: true)
//        }
//    }
//    func present(_ navigation: NavigationType, _ dataStore: DataStoreType? = nil, _ presentModalStyle: UIModalPresentationStyle? = nil) {
//        if check(navigation) {
//            let next = navigation.viewcontroller!
//            if let data = dataStore {
//                (next as? DataPassingType)?.bind(data)
//            }
//            if let style = presentModalStyle {
//                next.modalPresentationStyle = style
//            }
//            context.present(next, animated: true)
//        }
//    }
//    func presentWithRootViewcontroller(_ navigation: NavigationType, _ dataStore: DataStoreType?, _ presentModalStyle: UIModalPresentationStyle?) {
//        if let rootViewController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController {
//            if check(navigation) {
//                let next = navigation.viewcontroller!
//                if let data = dataStore {
//                    (next as? DataPassingType)?.bind(data)
//                }
//                if let style = presentModalStyle {
//                    next.modalPresentationStyle = style
//                }
//                rootViewController.present(next, animated: true)
//            }
//        }
//    }
//    func perform(_ segment: SegmentType, _ dataStore: DataStoreType? = nil) {
//        if check(segment) {
//            _ = segment.segue!
//        }
//    }
//    func pushViewController(_ navigation: NavigationType, dataStore: DataStoreType? = nil) {
//        if check(navigation) {
//            let next = navigation.viewcontroller!
//            if let data = dataStore {
//                (next as? DataPassingType)?.bind(data)
//            }
//            if let context = serachNavigationController() {
//                context.pushViewController(next, animated: true)
//            }
//        }
//    }
//    func popViewContoller(animated: Bool) {
//        self.context.navigationController?.popViewController(animated: animated)
//    }
//    private func check(_ next: NavigationType) -> Bool {
//        if next.viewcontroller != nil {
//            return true
//        }
//        print("\(next) :: viewcontroller is nil  ")
//        return false
//    }
//    private func check(_ next: SegmentType) -> Bool {
//        if next.segue != nil {
//            return true
//        }
//        print("\(next) :: Segment is nil  ")
//        return false
//    }
//    private func serachNavigationController() -> UINavigationController? {
//        return context.navigationController
////        if context.parent is UINavigationController {
////            return context.parent as? UINavigationController
////        }
//        print("serachNavigationController :: UINavigationController is nil  ")
////        return nil
//    }
//    func tabbarMovePreviousPage(_ index:Int?){
//        if let index = index {
//            if let tabbar = self.context.tabBarController,
//               let maxCount = tabbar.viewControllers?.count{
//                if index < maxCount {
//                    tabbar.selectedIndex = index
//                } else {
//                   fatalError("tabbar.viewControllers.count(\(maxCount)) 범위를 넘었습니다. index : \(index)")
//                }
//            }
//        } else {
//            if let tabbar = self.context.tabBarController {
//                if let tabbarVC = (tabbar as? TabBarController){
//                    tabbarVC.selectedIndex = tabbarVC.previousTabIndex
//                }
//            }
//        }
//    }
//    
//}
