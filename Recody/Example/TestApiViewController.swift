//
//  TestApiViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/02/08.
//

import Foundation
import UIKit
import Alamofire
class TestApiViewController: UIViewController{
    @IBOutlet weak var tableview: UITableView!
    var viewmodel = TestApiViewModel()
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    enum ApiEncoding {
        case JSON
        case URL
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.titleView?.isHidden = false
        setup()
        update()
    }
    func setup(){
        tableview.backgroundColor = .white
        tableview.delegate = self
        tableview.dataSource = self
//        viewmodel.list = [ApiCellModel(name: "1-1 유저 회원가입", command: .registerMemeber("ikmujn5@naver.com", "recody123!", "recody123!")),
//                          ApiCellModel(name: "1-2 이메일 체크", command: .checkValidEmail("ikmujn5@naver.com")),
//                          ApiCellModel(name: "1-3 비밀번호 재설정 이메일 인증", command: .resetPasswordToEmail("ikmujn5@naver.com")),
//                          ApiCellModel(name: "1-4 비밀번호 재설정", command: .changePassword("ikmujn5@naver.com", "Recody123!", "Recody123!")),
//                          ApiCellModel(name: "로그인", command: .login("ikmujn5@naver.com", "Recody123!")),
//                          ApiCellModel(name: "2-2 유저 정보 가져오기", command: .getUserInfomation),
//                          ApiCellModel(name: "2-3 닉네임 수정하기",  ", command: .search("", "", "")),
//                          ApiCellModel(name: "4-1 영화 상세정보 가져오기 v2", command: .getMovieDetail("영화 아이디")),
//                          ApiCellModel(name: "4-2 드라마 상세정보 가져오기", command: .getDramaDetail("드라마 아이디"))]
        viewmodel.list = [ApiCellModel(name: "1-1 유저 회원가입",
                                       headers: getHeaders(),
                                       params: [["email": "Tyshawn_Altenwerth@gmail.com"],
                                                ["password": "somePassword"],
                                                ["passwordConfirm": "somePassword"],
                                                ["name": "Recody"],
                                                ["nickname": "Recody"],
                                                ["pictureUrl": ""]],
                                       subDomain: "/v2/users/signup",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "1-2. 가입된 이메일이 존재하는 지 확인하기",
                                       headers: getHeaders(),
                                       params: [["email": "Tyshawn_Altenwerth@gmail.com"]],
                                       subDomain: "/v1/users/signup/check-duplicate",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "1-3 비밀번호 재설정 메일 보내기",
                                       headers: getHeaders(),
                                       params: [["email": "Tyshawn_Altenwerth@gmail.com"]],
                                       subDomain: "/v1/users/send-reset-email",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "1-4 비밀번호 재설정",
                                       headers: getHeaders(),
                                       params: [["email":"Tyshawn_Altenwerth@gmail.com"],
                                                 ["password":"newPassword"],
                                                 ["passwordConfirm":"newPassword"]],
                                       subDomain: "/v1/users/reset-password",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "2-2 유저 정보 가져오기",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v1/users/info",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "3-1. 작품 통합 검색 V3",
                                       headers: getHeaders(),
                                       params: [["categoryId":"cat-2"],
                                                ["keyword":"joy"],
                                                ["genreIds":"mg-1"]],
                                       method: .get,
                                       subDomain: "/v3/catalog/search",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "4-1 영화 상세정보 가져오기 V2",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v2/catalog/movie/mov-559",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "5-1. 위시 등록하기(찜하기)",
                                       headers: getHeaders(),
                                       params: [["contentId":"mov-683"]],
                                       method: .post,
                                       subDomain: "/v1/catalog/wish",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "5-2. 위시 제거하기(찜 제거하기)",
                                       headers: getHeaders(),
                                       params: [["contentId":"mov-683"]],
                                       method: .post,
                                       subDomain: "/v1/catalog/wish",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "5-3. 위시리스트 가져오기(찜한 작품 가져오기)",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v1/catalog/wish/wishes",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "6-1. 작품에 별점을 남기기",
                                       headers: getHeaders(),
                                       params: [[ "contentId":"mov-559"],
                                                ["score": "5"]],
                                       method: .post,
                                       subDomain: "/v1/catalog/rating",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "6-2. 유저가 작품에 남긴 별점을 가져오기",
                                       headers: getHeaders(),
                                       params: [[ "contentId":"mov-559"]],
                                       method: .get,
                                       subDomain: "/v1/catalog/rating",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "7-1. 커스텀 카테고리 등록하기",
                                       headers: getHeaders(),
                                       params: [[   "name":"ㅁㄴㅇ"],
                                                ["iconUrl":"http://something.com/img/ehfosffhh2hf39"]],
                                       method: .post,
                                       subDomain: "/v1/catalog/rating",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "7-2. 커스텀 카테고리 삭제하기",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v1/catalog/category/cat-1",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "7-3. 커스텀 카테고리 수정하기",
                                       headers: getHeaders(),
                                       params: [["name":"니니니"],
                                                ["iconUrl":"http://new-host.com/img/fhkefls"]],
                                       method: .post,
                                       subDomain: "/v1/catalog/category/cat-1",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "7-4. 카테고리 목록 가져오기",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v1/catalog/categories",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "9-1. 특정 작품에 대해 기록하기",
                                       headers: getHeaders(),
                                       params: [[ "contentId": "mov-559"],
                                                  ["note":"Lake Parker -- Kurtisview -- Wilberberg -- South Kaseychester -- Keaganside"],
                                                  ["title":"neural -- wireless -- haptic -- cross-platform"],
                                                  ["appreciationDate": "2022-09-01"]],
                                       method: .post,
                                       subDomain: "/v1/record",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "9-2. 감상평 삭제하기",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v1/record/rec-415",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "9-5. recordId 로 특정 기록 가져오기",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v1/record/rec-415",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "9-6. 내 감상평들 가져오기",
                                       headers: getHeaders(),
                                       params: [["size":"10"],
                                                 ["page":"1"],
                                                 ["categoryId":"cat-1"],
                                                 ["contentId":"mov-559"]],
                                       method: .get,
                                       subDomain: "/v1/record/records",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "9-7. 유저의 가장 최근 작성중인 감상평 가져오기",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v1/record/continuing",
                                       encoding: getEncoding(.URL)),
                           ApiCellModel(name: "9-8. 유저의 총 기록 개수",
                                       headers: getHeaders(),
                                       params: [["thisMonth":"false"]],
                                       method: .get,
                                       subDomain: "/v1/record/records/total",
                                       encoding: getEncoding(.URL)),
                           ApiCellModel(name: "10-1. 유저가 감상평을 쓴 작품 정보들 가져오기(작성중, 완료 포함)",
                                       headers: getHeaders(),
                                       params: [["size":"10"],["page":"0"],["order":"appreciationDate",]],
                                       method: .get,
                                       subDomain: "/v1/record/contents",
                                       encoding: getEncoding(.URL)),
                           ApiCellModel(name: "10-2 감상평을 작성중인 작품들 가져오기",
                                       headers: getHeaders(),
                                       params: [["size":"10"],["page":"0"],["order":"appreciationDate",]],
                                       method: .get,
                                       subDomain: "/v1/record/contents/continuing",
                                       encoding: getEncoding(.URL)),
                           ApiCellModel(name: "10-3 유저가 가장 최근에 감상평을 작성하고 있는 작품 정보 1개 가져오기",
                                       headers: getHeaders(),
                                       params: [["size":10],["page":0],["order":"appreciationDate",]],
                                       method: .get,
                                       subDomain: "/v1/record/contents/continuing",
                                       encoding: getEncoding(.URL)),
                          ApiCellModel(name: "11-1 커스텀 장르 등록하기",
                                       headers: getHeaders(),
                                       params: [["categoryId":"cat-1"],
                                                ["genreName":"bandwidth"],
                                                ["genreIconUrl":"https://orland.com"]],
                                       method: .post,
                                       subDomain: "/v1/catalog/genre",
                                       encoding: getEncoding(.JSON)),
                          ApiCellModel(name: "11-2 카테고리에 해당하는 장르들 가져오기(커스텀 포함)",
                                       headers: getHeaders(),
                                       method: .get,
                                       subDomain: "/v1/catalog/genres?categoryId=cat-1",
                                       encoding: getEncoding(.URL)),]
    }
    func getEncoding(_ encoding: ApiEncoding) -> ParameterEncoding {
        switch encoding {
        case .JSON:
            return JSONEncoding()
        case .URL:
            return URLEncoding()
        }
    }
    func getHeaders()-> [Dictionary<String,String>]{
        var arr = [Dictionary<String,String>]()
        arr.append(["ContentType":"application/x-www-form-urlencoded;charset=utf-8"])
        arr.append(["Accept-Language":"ko"])
        return arr
    }
    func update(){
        self.tableview.reloadData()
    }
    func moveDetail(_ index: Int){
        let storyboard = UIStoryboard(name: "TestApi", bundle: nil)
        if let next = storyboard.instantiateViewController(withIdentifier: "TestApiSetupViewController") as? TestApiSetupViewController {
//            next.viewmodel = TestApiDetailViewModel(request: self.viewmodel.list[index])
            next.viewModel.subDomain = viewmodel.list[index].subDomain
            next.viewModel.method = viewmodel.list[index].method
            next.viewModel.headers = viewmodel.list[index].headers
            next.viewModel.params = viewmodel.list[index].params
            next.viewModel.encoding = viewmodel.list[index].encoding
            next.viewModel.name = viewmodel.list[index].name
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
}
extension TestApiViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TestApiTalbeCell.Name) as? TestApiTalbeCell else {
            return UITableViewCell()
        }
        cell.lbTItle.text = viewmodel.list[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveDetail(indexPath.row)
    }
}
class TestApiViewModel {
    var list = [ApiCellModel]()
}

class TestApiTalbeCell: UITableViewCell {
    @IBOutlet weak var lbTItle: UILabel!
}

struct ApiCellModel {
    var name: String
    var headers : [Dictionary<String,Any>]
    var params : [Dictionary<String,Any>]
    var method = HTTPMethod.post
    var subDomain: String
    var encoding : ParameterEncoding = JSONEncoding.default
    init(name: String, headers:[Dictionary<String, Any>] = [Dictionary<String, Any>](), params:[Dictionary<String, Any>] = [Dictionary<String, Any>](), method: HTTPMethod = HTTPMethod.post, subDomain: String, encoding: ParameterEncoding) {
        self.name = name
        self.headers = headers
        self.params = params
        self.method = method
        self.subDomain = subDomain
        self.encoding = encoding
    }
}
