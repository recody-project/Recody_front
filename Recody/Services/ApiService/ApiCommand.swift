//
//  ApiCommand.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/07.
//

import Foundation
import Alamofire

enum ApiCommand {
    case loginGoogle(_ resourceAccessToken: String,
                     _ resourceRefreshToken: String) // 구글 로그인
    case registerMemeber(_ email: String,
                         _ password: String,
                         _ passwordConfirm: String,
                         _ name: String = "",
                         _ nickname: String = "",
                         _ pictureUrl: String = "") // 1-1 유저 회원가입
    case checkValidEmail(_ email: String) // 1-2 이메일 체크
    case resetPasswordToEmail ( _ email: String) // 1-3 비밀번호 재설정 이메일 인증
    case changePassword ( _ email: String,
                          _ password: String,
                          _ passwordConfirm: String,
                          _ verificationCode: String) // 1-4 비밀번호 재설정 ( 1-3 다음절차)
    case login(_ email: String,_ password: String) // 2-1. 유저 로그인
    case getUserInfomation // 2-2 유저 정보 가져오기
    case changeNickName(_ nickname: String) // 2-3 닉네임 수정하기
    case search(_ categoryId: String,
                _ keyword: String,
                _ language: String = "ko") // 3-1 작품 통합 검색
    case getMovieDetail( _ tmdbId : String,
                         _ language: String = "ko") // 4-1 영화 상세정보 가져오기
    case getDramaDetail( _ tmdbId : String,
                         _ language: String = "ko") // 4-2 드라마 상세정보 가져오기
    case setStarScore(_ contentId: String,
                      _ score: Int ) // 6-1 별점 남기기
    case getStarScore(_ contentId: String ) // 6-2 별점 가져오기
    var headers: Dictionary<String, Any> {
        var header = Dictionary<String, Any>()
        header["ContentType"] = "application/x-www-form-urlencoded;charset=utf-8"
        return header
    }
    var subDomain: String {
        switch self {
        case .loginGoogle ( _, _):
            return "/v1/login/google"
        case .registerMemeber ( _, _, _, _, _, _):
            return "/v2/users/signup"
        case .checkValidEmail ( _):
            return "/v1/users/signup/check-duplicate"
        case .resetPasswordToEmail ( _):
            return "/v1/users/send-reset-email"
        case .changePassword( _, _, _, _):
            return "/v1/users/reset-password"
        case .login( _, _):
            return "/v2/users/sign-in"
        case .getUserInfomation:
            return "/v1/users/info"
        case .changeNickName( _):
            return "/v1/users/nickname"
        case .search ( _, _, _):
            return "/v2/catalog/search"
        case .getMovieDetail ( _, _):
            return "/v1/catalog/movie"
        case .setStarScore ( _, _):
            return "/v1/catalog/rating"
        case .getStarScore ( _):
            return "/v1/catalog/rating"
        default:
            return ""
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getUserInfomation:
            return HTTPMethod.get
        case .search( _, _, _):
            return HTTPMethod.get
        case .getMovieDetail( _, _):
            return HTTPMethod.get
        case .getDramaDetail( _, _):
            return HTTPMethod.get
        case .getStarScore:
            return HTTPMethod.get
        default:
            return HTTPMethod.post
        }
    }
    var encoding: ParameterEncoding {
        switch self.method {
        case .get:
        return URLEncoding.default
        default:
        return JSONEncoding.default
        }
    }
}
