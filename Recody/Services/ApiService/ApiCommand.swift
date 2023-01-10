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
                          _ verificationCode: String) // 1-4 비밀번호 재설정 ( 1-3 다음절차) - 재설정을 위한 인증과정은 현재 없음
    case login(_ email: String, _ password: String) // 2-1 유저 로그인
    case getUserInfomation // 2-2 유저 정보 가져오기
    case changeNickName(_ nickname: String) // 2-3 닉네임 수정하기
    case search(_ categoryId: String,
                _ keyword: String,
                _ language: String = "ko") // 3-1 작품 통합 검색 - 삭제 예정
    case search(_ categroyId: String, _ keyword: String, _ genreId: String, _size: String, _page: String) // 3-1 작품 통합 검색 v3
    case getMovieDetail(_ moviedId: String, _ language: String = "ko") // 4-1 영화 상세정보 가져오기 v2
    case getDramaDetail( _ dramaId: String,
                         _ language: String = "ko") // 4-2 드라마 상세정보 가져오기
    case addWish(_ contentId: String) // 5-1 위시 등록하기(찜하기)
    case removeWish(_ contentId: String) // 5-2 위시 제거하기(찜 제거하기)
    case getWishList // 5-3 위시 리스트 가져오기(찜한 작품 가져오기)
    case setStarScore(_ contentId: String,
                      _ score: Int ) // 6-1 별점 남기기
    // score ( 0~ 10, 1당 별반개 )
    case getStarScore(_ contentId: String ) // 6-2 유저가 작품에 남긴 별점을 가져오기
    case addCustomCategory(_ name: String,
                           _ iconUrl: String = "") // 7-1 커스텀 카테고리 등록하기
    case removeCustomCategory(_ categoryId: String) // 7-2 커스텀 카테고리 삭제하기
    case modifyCustomCategory(_ categoryId: String,
                              _ name: String,
                              _ iconUrl: String) // 7-3 커스텀 카테고리 수정하기
    case getCategoryList // 7-4 카테고리 목록 가져오기
    case getGenreListWithCategory(_ categoryId: String) // 7-5 특정 카테고리에 해당하는 장르들 가져오기
    case setCustomCategory(_ contentId: String, _categoryId: String) // 8-1 특정 작품의 상세정보 수정하기(카테고리)
    case setCustomGenre(_ contentId: String, _genreIds: Array<String>) // 8-2 특정 작품의 상세정보 수정하기(장르)
    case addRecord(_ contentId: String,
                   _ title: String,
                   _ note: String,
                   _ appreciationDate: String,
                   _ appreciationNumber: Int = 1) // 9-1 감상평 등록하기
    // contentId 작품 ID
    // appreciationNumber 감상회차 -> 지정하지 않으면 1회로 간주됨
    // appreciationDate yyyy-MM-DD
    case removeRecord(_ recordId: String) // 9-2 감상평 삭제하기
    case completeRecord(_ recordId: String) // 9-3 감상평 작성 완료하기
    case continueRecord(_ recordId: String) // 9-4 감상평 작성 계속하기
    case getRecordWithId(_ recordId: String) // 9-5 recordId로 특정 기록 가져오기
    case getMyRecordList(_ contentId: String = "",
                         _ categoryId: String = "",
                         _ page: Int = 1,
                         _ size: Int = 10) // 9-6 내 감상평들 가져오기
    // contentId 입력시 categoryId는 무시됨
    // page number
    // size 가져올 개수 기본 10
    case getMyRecentContinuingRecord // 9-7 유저의 가장 최근 작성중인 감상평 가져오기 => 8번 api 사용
    case getMyRecordCount(_ thisMonth: Bool = false) // 9-8. 유저의 총 기록 개수
    case getAllRecord(_ size: Int = 10, _ page: Int = 0, apprciationDate: String = "") // 10-1 유저가 감상평을 쓴 작품 정보들 가져오기(작성중, 완료 포함)
    case getAllContinuingRecord(_ size: Int = 10, _ page: Int = 0, _ order: String = "") // 10-2 감상평을 작성중인 작품들 가져오기
    case getRecentContinuingRecord // 10-3 유저가 가장 최근에 감상평을 작성하고 있는 작품 정보 1개 가져오기
    case addCustomGenre(_ categoryId: String,
                         _ genreName: String,
                        _ genreIconUrl: String) // 11-1 커스텀 장르 등록하기
    case getRecommendationList(_ categoryId: String = "") // 12-1 추천 작품 가져오기
    case getRecordCountWithMonth(_ yearMonth: String) // 14-1 월 별 기록수 가져오기
    case getCategoryChart(_ yearMonth: String) // 14-2 카테고리 도표 보여주기
    case getLongestRecord(_ yearMonth: String) // 14-3 유저가 가장 길게 적은 작품 정보 가져오기
    case getGenreTop3(_yearMonth: String) // 14-4 유저 기록의 장르 TOP3 가져오기
    case getFristRecord(_ yearMonth: String) // 14-5 유저 첫 기록 가져오기
    case getTop3 // 14-6 유저 기록 명예의 전당 보여주기
    case getRatingChart(_yearMonth: String) // 14-7 유저 기록 작품 랭킹 보여주기
    case getReWatching(_yearMonth: String) // 14-8 유저의 재감상 기록 가져오기
    case getMostPopularContent(_yearMonth: String) // 14-9 레코디 전체에서 가장 인기있었던 작품 가져오기

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
        case .search(let categoryId, let keyword, _, _, _):
            return "/v2/catalog/search?categoryId=\(categoryId)&keyword=\(keyword)"
        case .getMovieDetail(let movieId,_):
            return "/v1/catalog/movie/\(movieId)"
        case .getDramaDetail(let dramaId, let language):
            return "/v1/catalog/drama/\(dramaId)?language=\(language)"
        case .addWish:
            return "/v1/catalog/wish"
        case .removeWish:
            return "/v1/catalog/wish"
        case .getWishList:
            return "/v1/catalog/wish/wishes"
        case .setStarScore:
            return "/v1/catalog/rating"
        case .getStarScore(let contentId):
            return "/v1/catalog/rating?contentId=\(contentId)"
        case .addCustomCategory:
            return "/v1/catalog/category"
        case .removeCustomCategory(let categoryId):
            return "/v1/catalog/category/\(categoryId)"
        case .modifyCustomCategory(let categoriId, _, _):
            return "/v1/catalog/category/\(categoriId)"
        case .getCategoryList:
            return "/v1/catalog/categories"
        case .getGenreListWithCategory(let categoryId):
            return "/v1/catalog/genres?categoryId=\(categoryId)"
        case .setCustomCategory(let contentId,_):
            return "/v1/catalog/content/\(contentId)/category"
        case .setCustomGenre(let contentId, _):
            return "/v1/catalog/content/\(contentId)/genres"
        case .addRecord:
            return "/v1/record"
        case .removeRecord(let recordId):
            return "/v1/record/\(recordId)"
        case .completeRecord(let recordId):
            return "/v1/record/\(recordId)/complete"
        case .continueRecord(let contentId):
            return "/v1/record/\(contentId)/continue"
        case .getRecordWithId(let recordId):
            return "/v1/record/\(recordId)"
        case .getMyRecordList(let size, let page, let categoryId, let contentId):
            return "/v1/record/records?size=\(size)&page=\(page)&categoryId=\(categoryId)&contentId=\(contentId)"
        case .getMyRecentContinuingRecord:
            return "/v1/record/continuing"
        case .getMyRecordCount(let thisMonth):
            return "/v1/record/records/total?thisMonth=\(thisMonth)"
        case .getAllRecord(let size, let page, let order):
            return "/v1/record/contents?size=\(size)&page=\(page)&order=\(order)"
        case .getAllContinuingRecord(let size, let page, let order):
            return "/v1/record/contents/continuing?size=\(size)&page=\(page)&order=\(order)"
        case .getRecentContinuingRecord:
            return "/v1/record/content/continuing"
        case .addCustomGenre:
            return "/v1/catalog/genre"
        case .getRecommendationList(let categoryId):
            return "/v1/recommendations?categoryId=\(categoryId)"
        case .getRecordCountWithMonth(let yearMonth):
            return "/v1/insight/records/count?yearMonth=\(yearMonth)"
        case .getCategoryChart(let yearMonth):
            return "/v1/insight/records/categoryChart?yearMonth=\(yearMonth)"
        case .getLongestRecord(let yearMonth):
            return "/v1/insight/records/longest?yearMonth=\(yearMonth)"
        case .getGenreTop3(let yearMonth):
            return "/v1/insight/records/genreTop3?yearMonth=\(yearMonth)"
        case .getFristRecord(let yearMonth):
            return "/v1/insight/records/first?yearMonth=\(yearMonth)"
        case .getTop3:
            return "/v1/insight/records/yearMonth/top3"
        case .getRatingChart(let yearMonth):
            return "/v1/insight/records/ratingChart?yearMonth=\(yearMonth)"
        case .getReWatching(let yearMonth):
            return "/v1/insight/records/rewatching?yearMonth=\(yearMonth)"
        case .getMostPopularContent(let yearMonth):
            return "/v1/insight/mostPopular?yearMonth=\(yearMonth)"
        default:
            return ""
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getUserInfomation:
            return .get
        case .search:
            return .get
        case .getMovieDetail:
            return .get
        case .getDramaDetail:
            return .get
        case .getWishList:
            return .get
        case .getStarScore:
            return .get
        case .getCategoryList:
            return .get
        case .getGenreListWithCategory:
            return .get
        case .getRecordWithId:
            return .get
        case .getMyRecordList:
            return .get
        case .getMyRecentContinuingRecord:
            return .get
        case .getMyRecordCount:
            return .get
        case .getAllRecord:
            return .get
        case .getAllContinuingRecord:
            return .get
        case .getRecentContinuingRecord:
            return .get
        case .getRecommendationList:
            return .get
        case .getRecordCountWithMonth:
            return .get
        case .getCategoryChart:
            return .get
        case .getLongestRecord:
            return .get
        case .getGenreTop3:
            return .get
        case .getFristRecord:
            return .get
        case .getTop3:
            return .get
        case .getRatingChart:
            return .get
        case .getReWatching:
            return .get
        case .getMostPopularContent:
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
