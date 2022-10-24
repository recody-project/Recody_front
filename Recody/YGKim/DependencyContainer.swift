//
//  DepencencyContainer.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/17.
//

import Foundation
import UIKit
// 의종성 주입 클래스
class DependencyContainer {
    static let shared = DependencyContainer()

    private var vcArr = [String:[Any]]()

    func bind<T : UIViewController & CommonVC >(vc : T,
                                                interactor:T.Interactor,
                                                router:SimpleRouter,
                                                presenter:T.Presenter){
        let name = vc.name
        if vcArr.contains(where: {$0.key == name}){ return }
        vcArr[name] = [interactor,
                       router,
                       presenter]
    }
    func unbind(_ vcName : String){
        if vcArr.contains(where: {$0.key == vcName}) {
           vcArr.removeValue(forKey: vcName)
        }
    }
}



