//
//  AlertService.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/23.
//

import Foundation
import UIKit
import SnapKit

protocol AlertServiceType {
    var context: UIViewController { get }
    init(_ context: UIViewController)
    func show(title: String, msg: String, actions: [UIAlertAction])
    func showActionSheet(title: String, msg: String, actions: [UIAlertAction])
    func showToast(_ msg:String)
}
class AlertService: AlertServiceType {
    var context: UIViewController
    var toastViews = [UIView?]()
    required init(_ context: UIViewController) {
        self.context = context
    }
    func show(title: String, msg:String, actions:[UIAlertAction]){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        actions.forEach({
            alert.addAction($0)
        })
        context.present(alert, animated: true)
    }
    func showActionSheet(title: String, msg:String, actions:[UIAlertAction]) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        actions.forEach({
            alert.addAction($0)
        })
        context.present(alert, animated: true)
    }
    func showToast(_ msg:String){
        let toastView = UIView()
        self.toastViews.append(toastView)
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            toastView.alpha = 0.0
            toastView.backgroundColor = .black.withAlphaComponent(0.5)
            window.addSubview(toastView)
            window.bringSubviewToFront(toastView)
            toastView.layer.cornerRadius = 15
            toastView.snp.makeConstraints({
                $0.width.equalTo(140)
                $0.height.equalTo(40)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-60)
            })
            let lbMsg = UILabel()
            toastView.addSubview(lbMsg)
            lbMsg.text = msg
            lbMsg.textColor = .white
            lbMsg.font = .systemFont(ofSize: 14)
            lbMsg.snp.makeConstraints({
                $0.centerX.centerY.equalToSuperview()
            })
            UIView.animate(withDuration: 1.0, delay: 0.0,options:[.curveEaseOut], animations: {
                toastView.alpha = 1.0
            })
            UIView.animate(withDuration: 1.0, delay: 0.0,options:[.curveEaseIn], animations: {
                toastView.alpha = 0.0
            },completion: { _ in
                toastView.removeFromSuperview()
                self.toastViews.removeFirst()
            })
        }
    }
}


