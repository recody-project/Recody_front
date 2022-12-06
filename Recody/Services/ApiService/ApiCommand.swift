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
    case getMovieDetail( _ tmdbId: String,
                         _ language: String = "ko") // 4-1 영화 상세정보 가져오기
    case getDramaDetail( _ tmdbId: String,
                         _ language: String = "ko") // 4-2 드라마 상세정보 가져오기
    case addWish(_ contentId: String) // 5-1 위시 등록하기(찜하기)
    case removeWish(_ contentId: String) // 5-2 위시 제거하기
    case getWishList // 5-3 위시 리스트 가져오기
    case setStarScore(_ contentId: String,
                      _ score: Int ) // 6-1 별점 남기기
    // score ( 0~ 10, 1당 별반개 )
    case getStarScore(_ contentId: String ) // 6-2 유저가 작품에 남긴 별점을 가져오기
    case addCustomCategory(_ name: String,
                           _ iconUrl: String) // 7-1 커스텀 카테고리 등록하기
    case removeCustomCategory(_ categoryId: String) // 7-2 커스텀 카테고리 삭제하기
    case modifyCustomCategory(_ categoryId: String,
                              _ name: String,
                              _ iconUrl: String) // 7-3 커스텀 카테고리 수정하기
    case getCategoryList // 7-4 카테고리 목록 가져오기
    case addRecord(_ contentId: String,
                   _ title: String,
                   _ note: String,
                   _ appreciationDate: String,
                   _ appreciationNumber: Int) // 9-1 감상평 등록하기
    // contentId 작품 ID
    // appreciationNumber 감상회차 -> 지정하지 않으면 1회로 간주됨
    // appreciationDate yyyy-MM-DD
    case removeRecord(_ contentId: String) // 9-2 감상평 삭제하기
    case completeRecord(_ contentId: String) // 9-3 감상평 작성 완료하기
    case continueRecord(_ contentId: String) // 9-4 감상평 작성 계속하기
    case getRecord(_ contentId: String) // 9-5 감상평 한개 가져오기
    case getMyRecordList(_ contentId: String?,
                         _ categoryId: String?,
                         _ page: Int?,
                         _ size: Int = 10) // 9-6 내 감상평들 가져오기
    // contentId 입력시 categoryId는 무시됨
    // page number
    // size 가져올 개수 기본 10
    case recentContinuingRecord // 9-7 유저의 가장 최근 작성중인 감상평 가져오기
    case getMyRecordCount(_ thisMonth: Bool = false) // 9-8. 유저의 총 기록 개수
    
    // 10-1 유저가 감상평을 쓴 작품 정보들 가져오기
//    /v1/record/contents?size=10&page=0
    
    case addCustomGenre(_ categoryId: String,
                         _ genreName: String,
                        _ genreIconUrl: String) // 11-1 커스텀 장르 등록하기
    var headers: Dictionary<String, Any> {
        var header = Dictionary<String, Any>()
        header["ContentType"] = "application/x-www-form-urlencoded;charset=utf-8"
        header["Accept-Language"] = "ko"
        return header
    }
    var subDomain: String {
        switch self {
        case .loginGoogle:
            return "/v1/login/google"
        case .registerMemeber:
            return "/v2/users/signup"
        case .checkValidEmail:
            return "/v1/users/signup/check-duplicate"
        case .resetPasswordToEmail:
            return "/v1/users/send-reset-email"
        case .changePassword:
            return "/v1/users/reset-password"
        case .login:
            return "/v2/users/sign-in"
        case .getUserInfomation:
            return "/v1/users/info"
        case .changeNickName:
            return "/v1/users/nickname"
        case .search:
            return "/v2/catalog/search"
        case .getMovieDetail:
            return "/v1/catalog/movie"
        case .addWish:
            return "/v1/catalog/wish"
        case .removeWish:
            return ""
        case .getWishList:
            return "/v1/catalog/wish/wishes"
        case .setStarScore:
            return "/v1/catalog/rating"
        case .getStarScore:
            return "/v1/catalog/rating"
        case .addCustomCategory:
            return "/v1/catalog/category"
        case .removeCustomCategory( let categoryId):
            return "/v1/catalog/category/\(categoryId)"
        case .modifyCustomCategory( let categoriId, _, _):
            return "/v1/catalog/category/\(categoriId)"
        case .getCategoryList:
            return "/v1/catalog/categories"
        case .addRecord:
            return "/v1/record"
        case .removeRecord(let contentId):
            return "/v1/record/\(contentId)"
        case .completeRecord(let contentId):
            return "/v1/record/\(contentId)/complete"
        case .continueRecord(let contentId):
            return "/v1/record/\(contentId)/continue"
        case .getRecord(let contentId):
            return "/v1/record/\(contentId)"
        case .getMyRecordList:
            return "/v1/record/records"
        case .recentContinuingRecord:
            return "/v1/record/continuing"
        case .getMyRecordCount:
            return "/v1/record/records/total"
        case .addCustomGenre:
            return "/v1/catalog/genre"
        default:
            return ""
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getUserInfomation:
            return .get
        case .search( _, _, _):
            return .get
        case .getMovieDetail( _, _):
            return .get
        case .getDramaDetail( _, _):
            return .get
        case .getWishList:
            return .get
        case .getStarScore:
            return .get
        case .getCategoryList:
            return .get
        case .getRecord:
            return .get
        case .getMyRecordList:
            return .get
        case .recentContinuingRecord:
            return .get
        case .getMyRecordCount:
            return .get
        default:
            return .post
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
