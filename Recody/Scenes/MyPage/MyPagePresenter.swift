//
//  MyPagePresenter.swift
//  Recody
//
//  Created by 마경미 on 19.10.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MyPagePresentationLogic {
  func presentSomething(response: MyPage.Something.Response)
}

class MyPagePresenter: MyPagePresentationLogic {
  weak var viewController: MyPageDisplayLogic?

  // MARK: Do something

  func presentSomething(response: MyPage.Something.Response) {
    let viewModel = MyPage.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
