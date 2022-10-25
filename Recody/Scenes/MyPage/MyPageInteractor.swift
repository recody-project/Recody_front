//
//  MyPageInteractor.swift
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

protocol MyPageBusinessLogic
{
  func doSomething(request: MyPage.Something.Request)
}

protocol MyPageDataStore
{
  //var name: String { get set }
}

class MyPageInteractor: MyPageBusinessLogic, MyPageDataStore
{
  var presenter: MyPagePresentationLogic?
  var worker: MyPageWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: MyPage.Something.Request)
  {
    worker = MyPageWorker()
    worker?.doSomeWork()
    
    let response = MyPage.Something.Response()
    presenter?.presentSomething(response: response)
  }
}