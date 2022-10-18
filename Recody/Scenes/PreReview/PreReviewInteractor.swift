//
//  ReviewInteractor.swift
//  Recody
//
//  Created by 마경미 on 23.09.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PreReviewBusinessLogic {
    func doSomething(request: PreReview.API.Request)
}

protocol PreReviewDataStore {
  // var name: String { get set }
}

class PreReviewInteractor: PreReviewBusinessLogic, PreReviewDataStore {
  var presenter: PreReviewPresentationLogic?
  var worker: PreReviewWorker?
  // var name: String = ""

  // MARK: Do something

  func doSomething(request: PreReview.API.Request) {
    worker = PreReviewWorker()
    worker?.doSomeWork()
//    
//    let response = PreReview.Something.Response()
//    presenter?.presentSomething(response: response)
  }
}
