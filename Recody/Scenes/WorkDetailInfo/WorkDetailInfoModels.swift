//
//  WorkDetailInfoModels.swift
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

enum WorkDetailInfo {
  // MARK: Use cases
    struct Genre {
        let genreId: Int
        let genreName: String
        let source: String
        let category: String
    }

    struct Data {
        let personalizedUserId: Int
        let contentId: String
        let tmbId: Int
        let originalLanguage: String
        let title: String
        let originalTitle: String
        let overview: String
        let popularity: Float
        let posterPath: URL
        let genres: [Genre]
        // let productionCountries
        let releaseDate: String
        let runtime: Int
        let revenue: Int
        let status: String
        let voteAverage: Float
        let voteCount: Int
    }

  enum API {
    struct Request {
    }
    struct Response {
        let mesage: String
        let data: Data
    }
    struct ViewModel {
        let posterPath: URL
        let title: String
        let genres: [Genre]
        let releaseDate: String
        // directr, actors 없음
        let director: String
        let actors: [String]
        let runtime: Int
        let overview: String
    }
  }
}
