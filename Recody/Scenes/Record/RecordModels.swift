//
//  RecordModels.swift
//  Recody
//
//  Created by 마경미 on 2022/08/30.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Record {
  // MARK: Use cases
    struct Work {
        let id: String
        let name: String
        let image: String
    }

  enum API {
    struct Request {
    }
    struct Response {
    }
    struct ViewModel {
    }
  }
}
