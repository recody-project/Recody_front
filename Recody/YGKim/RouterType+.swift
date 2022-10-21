//
//  RouterType.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/19.
//

import Foundation
import UIKit

protocol RouterType {
    init(context : UIViewController)
    var context:UIViewController { get }
    func present(_ navigation: NavigationType ,_ dataStore : Any?) //UIViewController 에서 직접 Present
    func perform(_ segment: SegmentType ,_ dataStore : Any?) // 세그먼트를 이용한 화면이동
    func pushViewController(_ navigation: NavigationType ,_ dataStore : Any?) //UINavigationController
}

protocol DataPassingType {
    func bind(_ data:Any)
}

protocol NavigationType {
    var viewcontroller:UIViewController? { get }
}
protocol SegmentType {
    var segue:UIStoryboardSegue? { get }
}
protocol RoutingLogicType {
    associatedtype Navigation:NavigationType
    associatedtype Segment:SegmentType
}


class SimpleRouter : RouterType {
    var context: UIViewController
    required init(context:UIViewController){
        self.context = context
    }
    func present(_ navigation:NavigationType, _ dataStore: Any? = nil){
        if check(navigation) {
            let next = navigation.viewcontroller!
            if let data = dataStore {
                (next as? DataPassingType)?.bind(data)
            }
            context.present(next, animated: true)
        }
    }
    func perform(_ segment: SegmentType,_ dataStore: Any? = nil) {
        if check(segment) {
            let segue = segment.segue!
        }
    }
    func pushViewController(_ navigation:NavigationType, _ dataStore: Any? = nil) {
        if check(navigation) {
            let next = navigation.viewcontroller!
            if let data = dataStore {
                (next as? DataPassingType)?.bind(data)
            }
            if let context = serachNavigationController() {
                context.pushViewController(next, animated: true)
            }
        }
    }
    private func check(_ next:NavigationType) -> Bool {
        if next.viewcontroller != nil {
            return true
        }
        print("\(next) :: viewcontroller is nil  ")
        return false
    }
    private func check(_ next:SegmentType) -> Bool {
        if next.segue != nil {
            return true
        }
        print("\(next) :: Segment is nil  ")
        return false
    }
    private func serachNavigationController() -> UINavigationController? {
        if context.parent is UINavigationController {
            return context.parent as? UINavigationController
        }
        print("serachNavigationController :: UINavigationController is nil  ")
        return nil
    }
}
