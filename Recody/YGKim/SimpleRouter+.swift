//
//  RoutingWork.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/19.
//

import Foundation
import UIKit

protocol RouterType {
    init(context : UIViewController)
    var context:UIViewController { get }
    func present(_ navigation: RoutingLogic.Navigation ,_ dataStore : Any?) //UIViewController 에서 직접 Present
    func perform(_ segment: RoutingLogic.Segment ,_ dataStore : Any?) // 세그먼트를 이용한 화면이동
    func pushViewController(_ navigation: RoutingLogic.Navigation ,_ dataStore : Any?) //UINavigationController
}

class SimpleRouter : RouterType {
    var context: UIViewController
    required init(context:UIViewController){
        self.context = context
    }
    func present(_ navigation:RoutingLogic.Navigation, _ dataStore: Any? = nil){
        if check(navigation) {
            let next = navigation.viewcontroller!
            if let data = dataStore {
                // 데이터 바인딩
                // 강제 언랩핑 -> ! 가능
            }
            context.present(next, animated: true)
        }
    }
    func perform(_ segment: RoutingLogic.Segment,_ dataStore: Any? = nil) {
        if check(segment) {
            let segue = segment.segue!
        }
    }
    func pushViewController(_ navigation:RoutingLogic.Navigation, _ dataStore: Any? = nil) {
        if check(navigation) {
            let next = navigation.viewcontroller!
            if let data = dataStore {
                // 데이터 바인딩
                // 강제 언랩핑 -> ! 가능
            }
            if let context = serachNavigationController() {
                context.pushViewController(next, animated: true)
            }
        }
    }
    private func check(_ next:RoutingLogic.Navigation) -> Bool {
        if next.viewcontroller != nil {
            return true
        }
        print("\(next) :: viewcontroller is nil  ")
        return false
    }
    private func check(_ next:RoutingLogic.Segment) -> Bool {
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
