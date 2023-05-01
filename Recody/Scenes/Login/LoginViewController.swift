//
//  LoginViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/04.
//

import Foundation
import UIKit
import SnapKit


class LoginViewController: UIViewController {
    @IBOutlet weak var lbFindId: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegisterMemeber: UIButton!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    var pageViewController = PageViewController()
    
    var animatingTimer = Timer()
    var viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    static func getInstanse() -> LoginViewController{
        guard let vc =  UIStoryboard(name: "login", bundle: nil).instantiateInitialViewController() as? LoginViewController
        else {
            fatalError()
        }
        return vc
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        slideAnimation(start: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        slideAnimation(start: false)
    }
    enum UseCase: Int {
        case findID = 1
        case login = 2
        case registerMemeber = 3
        case slideImageClick = 4
        case loginApple = 201
        var number: Int {
            return self.rawValue
        }
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer){
        guard let tag = sender.view?.tag else { return }
        guard let useCase = UseCase(rawValue: tag) else { print("clickEvent : 등록안된 TAG = \(tag)"); return }
        switch useCase {
        case .login:
            let methodVC = LoginMethodViewController.getInstanse()
            methodVC.transitioningDelegate = self
            methodVC.modalPresentationStyle = .custom
            methodVC.delegate = self
            self.present(methodVC, animated: true)
        case .slideImageClick:
            
            self.navigationController?.pushViewController(TestApiViewController.getInstanse(), animated: true)
        case .registerMemeber:
            self.navigationController?.pushViewController(RegisterMemberViewController.getInstanse(), animated: true)
        default:
        break
        }
        update()
    }
    func setup(){
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewModel.maxPageIndex + 1
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = UIColor(hexString: "d9d9d9")
        
        lbFindId.setUnderline()
        lbFindId.isUserInteractionEnabled = true
        lbFindId.tag = UseCase.findID.rawValue
        btnLogin.tag = UseCase.login.rawValue
        btnRegisterMemeber.tag = UseCase.registerMemeber.rawValue
        lbFindId.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnLogin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnRegisterMemeber.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        pageViewController.setUpLayout(viewController: self,superView: vwContainer)
        setUpPageViewController()
    }
    func setUpPageViewController(){
        let imgViews = self.viewModel.imgs.map({ img -> UIImageView in
            let imgV = UIImageView()
            imgV.image = img
            return imgV
        })
        let vcs = imgViews.map({ imgV -> UIViewController in
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            vc.view.addSubview(imgV)
            imgV.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
            imgV.isUserInteractionEnabled = true
            imgV.tag = UseCase.slideImageClick.rawValue
            imgV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
            return vc
        })
        self.pageViewController.dataViewControllers = vcs
        self.pageViewController.dataViewControllers.forEach({
            $0.view.layoutIfNeeded()
        })
        self.pageViewController.moveSlidePage(index: 0)
    }
    func update(){
        
    }
    func slideAnimation(start: Bool){
        if start {
            if viewModel.animating { return }
            self.animatingTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(pageViewControllerSlideAction), userInfo: nil, repeats: true)
        } else {
            self.animatingTimer.invalidate()
        }
    }
    @objc func pageViewControllerSlideAction(){
        
        if viewModel.currentPageIndex == viewModel.maxPageIndex {
            viewModel.currentPageIndex -= 1
            viewModel.isMoveRight = false
        }else if(viewModel.currentPageIndex == 0){
            viewModel.currentPageIndex += 1
            viewModel.isMoveRight = true
        }else {
            if viewModel.isMoveRight {
                viewModel.currentPageIndex += 1
            }else {
                viewModel.currentPageIndex -= 1
            }
        }
        
        let next = viewModel.currentPageIndex
        pageControl.currentPage = next
        pageViewController.moveSlidePage(index: next)
    }
}

extension LoginViewController: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let modal =  HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
        if let vc = presented as? LoginMethodViewController {
            vc.modal = modal
        }
          return modal
      }
}
extension LoginViewController: LoginMethodViewControllerDelegate {
    func findID() {
//        self.presenter?.alertService.showToast("findID")
    }
    func loginEmail() {
        
        self.navigationController?.pushViewController(EmailLoginViewController.getInstanse(), animated: true)
    }
    func loginSNS(_ method: LoginMethodViewController.LoginMethod) {
        switch method {
//        case .kakao:
//        break
//        case .facebook:
//        break
//        case .naver:
//        break
//        case .apple:
//            onAppleID()
//            self.interactor?.just(UseCase.loginApple)
//            self.presenter?.alertService.showToast("SNS Login(\(index))")
//        break
        default:
        break
//            self.presenter?.alertService.showToast("SNS Login(\(method))")
        }
    }
    

}

class LoginViewModel {
    var imgs = [UIImage]()
    var animating = false
    var currentPageIndex = 0
    var maxPageIndex = 3
    var isMoveRight = true
    
    init(){
        let imgNames = ["common (1)","common (2)","common (3)","common (4)"]
        imgNames.forEach({
            if let img = UIImage(named: $0) {
                imgs.append(img)
            }
        })
    }
}
