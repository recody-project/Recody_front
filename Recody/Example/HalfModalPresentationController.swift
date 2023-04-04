//
//  HalfModalPresentationController.swift
//  thinkfreeplus
//
//  Created by Snuh_Mobile on 2023/03/28.
//  Copyright © 2023 Poker. All rights reserved.
//

import Foundation
import UIKit
class HalfModalPresentationController: UIPresentationController {
    
    let backgroundView = UIView()
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    var check: Bool = false
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        backgroundView.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0,
                               y: self.containerView!.frame.height * 0.5 ),
               size: CGSize(width: self.containerView!.frame.width,
                            height: self.containerView!.frame.height * 0.5))
    }
    
    // 모달이 올라갈 때 뒤에 있는 배경을 검은색 처리해주는 용도
    override func presentationTransitionWillBegin() {
        self.containerView?.backgroundColor = .clear
        self.containerView!.addSubview(backgroundView)
    }
    
    // 모달이 없어질 때 검은색 배경을 슈퍼뷰에서 제거
    override func dismissalTransitionWillBegin() {
       
    }
    
    // 모달의 크기가 조절됐을 때 호출되는 함수
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        backgroundView.frame = self.containerView!.frame
//        self.presentedView?.makeRoundedSpecificCorner(corners: [.topLeft, .topRight], cornerRadius: 15)
    }
    
    @objc func dismissController(_ handler: @escaping () -> Void) {
        backgroundView.removeFromSuperview()
        self.presentedViewController.dismiss(animated: true, completion: {
            handler()
        })
    }
}
