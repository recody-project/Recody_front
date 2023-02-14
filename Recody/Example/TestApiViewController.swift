//
//  TestApiViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/02/08.
//

import Foundation
import UIKit

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
        viewmodel.list = [ApiCellModel(name: "1-1 유저 회원가입", command: .registerMemeber("ikmujn5@naver.com", "recody123!", "recody123!")),
                          ApiCellModel(name: "1-2 이메일 체크", command: .checkValidEmail("ikmujn5@naver.com")),
                          ApiCellModel(name: "1-3 비밀번호 재설정 이메일 인증", command: .resetPasswordToEmail("ikmujn5@naver.com")),
                          ApiCellModel(name: "1-4 비밀번호 재설정", command: .changePassword("ikmujn5@naver.com", "Recody123!", "Recody123!")),
                          ApiCellModel(name: "로그인", command: .login("ikmujn5@naver.com", "Recody123!")),
                          ApiCellModel(name: "2-2 유저 정보 가져오기", command: .getUserInfomation),
                          ApiCellModel(name: "2-3 닉네임 수정하기", command: .changeNickName("레코디")),
                          ApiCellModel(name: "3-1 작품 통합 검색 v3", command: .search("", "", "")),
                          ApiCellModel(name: "4-1 영화 상세정보 가져오기 v2", command: .getMovieDetail("영화 아이디")),
                          ApiCellModel(name: "4-2 드라마 상세정보 가져오기", command: .getDramaDetail("드라마 아이디"))]
                        
    } 
    func update(){
        self.tableview.reloadData()
    }
    func moveDetail(_ index: Int){
        let storyboard = UIStoryboard(name: "TestApi", bundle: nil)
        if let next = storyboard.instantiateViewController(withIdentifier: "TestApiDetailViewController") as? TestApiDetailViewController {
            next.viewmodel = TestApiDetailViewModel(request: self.viewmodel.list[index])
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
    var name : String
    var command : ApiCommand
}
