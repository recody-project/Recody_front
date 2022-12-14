//
//  EditGenreRouter.swift
//  Recody
//
//  Created by 마경미 on 2022/09/05.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol EditGenreRoutingLogic {
}

protocol EditGenreDataPassing {
  var dataStore: EditGenreDataStore? { get }
}

class EditGenreRouter: NSObject, EditGenreRoutingLogic, EditGenreDataPassing {
  weak var viewController: EditGenreViewController?
  var dataStore: EditGenreDataStore?
}
