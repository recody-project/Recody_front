//
//  Animator.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/20.
//

import Foundation
import UIKit

protocol AnimatorType{
    init(_ context:UIViewController)
    func fold(changeHeight:CGFloat,heightConstraint:NSLayoutConstraint,_ completionBlock:((Bool) -> Void)?)
}

class Animator : AnimatorType {
    var context : UIViewController
    
    required init(_ context: UIViewController) {
        self.context = context
    }
    func fold(changeHeight:CGFloat,heightConstraint:NSLayoutConstraint,_ completionBlock:((Bool) -> Void)?){
//    heightConstraint;.constant = changeHeight
//        UIView.animate(withDuration: 0.3, animations: {
            
//        },completion:completionBlock)
        
//        let a = UIView.animate(withDuration: 0.3, animations: <#T##() -> Void#>)
//        completion ((Bool) -> Void)?
         //animations () -> Void
//        let a = UIView.animate(withDuration: 0.3,animations: )
//        {
//           self.vwHead.alpha = 0.0
//           self.vwHeadBackground.alpha = 0.0
//           self.pageControl.alpha = 0.0
//           self.view.layoutIfNeeded()
//       }completion: { act in
//           self.isAnimateFold = false
//       }
    }
    
    
}
