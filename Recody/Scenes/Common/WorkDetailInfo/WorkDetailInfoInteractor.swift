//
//  WorkDetailInfoInteractor.swift
//  Recody
//
//  Created by 마경미 on 2022/08/23.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WorkDetailInfoBusinessLogic {
  func doSomething(request: WorkDetailInfo.API.Request)
}

protocol WorkDetailInfoDataStore {
  // var name: String { get set }
}

class WorkDetailInfoInteractor: WorkDetailInfoBusinessLogic, WorkDetailInfoDataStore {
  var presenter: WorkDetailInfoPresentationLogic?
  var worker: WorkDetailInfoWorker?
  // var name: String = ""

  // MARK: Do something

  func doSomething(request: WorkDetailInfo.API.Request) {
    worker = WorkDetailInfoWorker()
    worker?.doSomeWork()

//      let response = WorkDetailInfo.API.Response(mesage: "", data: WorkDetailInfo.Data(personalizedUserId: <#Int#>, contentId: <#String#>, tmbId: <#Int#>, originalLanguage: <#String#>, title: <#String#>, originalTitle: <#String#>, overview: <#String#>, popularity: <#Float#>, posterPath: <#URL#>, genres: <#[WorkDetailInfo.Genre]#>, releaseDate: <#String#>, runtime: <#Int#>, revenue: <#Int#>, status: <#String#>, voteAverage: <#Float#>, voteCount: <#Int#>))
//    presenter?.presentSomething(response: response)
  }
}