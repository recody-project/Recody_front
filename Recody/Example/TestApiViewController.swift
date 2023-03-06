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
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    func setup(){
        tableview.delegate = self
        tableview.dataSource = self
//        viewmodel.list = [ApiCellModel(name: "1-1 유저 회원가입", command: .registerMemeber("ikmujn5@naver.com", "recody123!", "recody123!")),
//                          ApiCellModel(name: "1-2 이메일 체크", command: .checkValidEmail("ikmujn5@naver.com")),
//                          ApiCellModel(name: "1-3 비밀번호 재설정 이메일 인증", command: .resetPasswordToEmail("ikmujn5@naver.com")),
//                          ApiCellModel(name: "1-4 비밀번호 재설정", command: .changePassword("ikmujn5@naver.com", "Recody123!", "Recody123!")),
//                          ApiCellModel(name: "로그인", command: .login("ikmujn5@naver.com", "Recody123!")),
//                          ApiCellModel(name: "2-2 유저 정보 가져오기", command: .getUserInfomation),
//                          ApiCellModel(name: "2-3 닉네임 수정하기", command: .changeNickName("레코디")),
//                          ApiCellModel(name: "3-1 작품 통합 검색 v3", command: .search("", "", "")),
//                          ApiCellModel(name: "4-1 영화 상세정보 가져오기 v2", command: .getMovieDetail("영화 아이디")),
//                          ApiCellModel(name: "4-2 드라마 상세정보 가져오기", command: .getDramaDetail("드라마 아이디"))]
        viewmodel.list = [ApiCellModel(name: "1-1 유저 회원가입",
                                       headers: getHeaders(),
                                       params: [["email":""],
                                                ["password":""],
                                                ["passwordConfirm":""],
                                                ["name":""],
                                                ["nickname":""],
                                                ["pictureUrl":""]],
                                       subDomain: "/v2/users/signup",
                                       encoding: JSONEncoding.default),
                          ApiCellModel(name: "1-2 이메일 체크", 
                                       headers: getHeaders(),
                                       params: [["email":""]],
                                       subDomain: "/v1/users/signup/check-duplicate",
                                       encoding: JSONEncoding.default)]
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
    var headers : [Dictionary<String,String>]
    var params : [Dictionary<String,String>]
    var method = HTTPMethod.post
    var subDomain: String
    var encoding : ParameterEncoding = JSONEncoding.default
    init(name: String, headers: [Dictionary<String, String>], params: [Dictionary<String, String>], method: HTTPMethod = HTTPMethod.post, subDomain: String, encoding: ParameterEncoding) {
        self.name = name
        self.headers = headers
        self.params = params
        self.method = method
        self.subDomain = subDomain
        self.encoding = encoding
    }
}
