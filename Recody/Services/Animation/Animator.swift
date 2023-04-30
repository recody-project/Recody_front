//
//  Animator.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/20.
//

import Foundation
import UIKit

protocol AnimatorType{
    init(_ context: UIViewController)
    func animate(_ duration: CGFloat,animationBlock:@escaping ()->Void,_ completionBlock:((Bool) -> Void)?)
}

class Animator: AnimatorType {
    var context: UIViewController
    required init(_ context: UIViewController) {
        self.context = context
    }
    func animate(_ duration:CGFloat,animationBlock: @escaping ()->Void,_ completionBlock:((Bool) -> Void)?){
        UIView.animate(withDuration: duration, animations: animationBlock,completion: completionBlock)
    }
}
