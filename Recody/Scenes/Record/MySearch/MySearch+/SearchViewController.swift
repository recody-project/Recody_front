//
//  MySearchViewController_ex.swift
//  Recody
//
//  Created by 마경미 on 11.11.22.
//

import Foundation
import UIKit


class SearchViewController: CommonVC, DataPassingType, ObservingTableCellEvent {
//    func eventFromTableCell(code: Int) {
//        guard let cellEvent = SearchCellEvent(rawValue: code) else { return }
//    }
    var viewModel = MySearchViewModel()
    var tableList: [TableCellViewModel] = [TableCellViewModel]()
    var mySearchs: [String] = [
        "블랙핑크", "블랙팬서", "미움 받을 용기", "닥터스트레인지"
    ]
    
    // 검색, 검색 취소, 비우기, 기록 삭제, 필터
    enum UseCase: Int, OrderType {
        case search = 100
        case cancel_search = 101
        case empty = 102
        case delete = 103
        case filter = 104
        var number: Int {
            return self.rawValue
        }
    }
    
    // outlet 연결 (검색 기능 활성화)
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    func bind(_ data: DataStoreType) {
        
    }
    
    func routing(orderNumber: Int) {
        if orderNumber == 1 {
            
        } else {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
//    func setUp() {
//        navigationItem.searchController = searchController
//
//        searchController.delegate = self
//        searchController.searchBar.delegate = self
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
//        searchController.delegate = self
//    }
    
//    override func talbeView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableView == resultVC.tableView ? fileteredData.count : dataArray.count
//
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = (tableView == resultVC.tableView ? fileteredData[indexPath.row].main : dataArray[indexPath.row].main)
//        return cell
//    }
    
    // cell 클릭 시 검색 바로 이동
    // display 쪽에서 router 호출
    override func display(orderNumber: Int) {
        guard let test = UseCase.init(rawValue: orderNumber) else { return } // search -> interactor가 받음
        let worker = self.interactor?.just(UseCase.search) // worker가 반환
        worker?.drop() // api 호출 x
        // worker?.api(.) - api 호출
        
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
        // search는 검색버튼 눌렀을 때 api 호출
        // filter는 누르면 modal창 띄우기
        case .filter:
            self.router?.pushViewController(RoutingLogic.Navigation., dataStore: <#T##DataStoreType?#>)
        case .cancel_search:
        case .delete:
        case .empty:
        default:
            break
        }
    }
    
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
        if let command = UserCase.init(rawValue: orderNumber) {
            switch command {
            case
            }
        }
    }
    
    override func displayErorr(orderNumber: Int, msg: String?) {
        <#code#>
    }
}

struct MySearchViewModel {
    
}


// 이전에 필요한 것 -> 1. empty history view, 2. history view, 3. search view
// 처음에 필요한 것 -> 검색 히스토리 (삭제 가능) , 검색 히스토리가 없을 경우도 생각해보기


// 검색을 버튼 눌렀을 때만 업데이트할 것 인지, 타이핑할 때 마다 업데이트해야 할 것인지 서버팀과 상의하기 (기억속엔 전자였던 것 같음)
// 타이핑 중 search bar에 취소 버튼 나타나기
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
        self.data.filterValue = self.data.items.filter {
            $0.localizedCaseInsensitiveContains(text)
        }
        searchBar.showsCancelButton = true
        self.tableView.reloadData()
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        <#code#>
    }
    func willPresentSearchController(_ searchController: UISearchController) {
        <#code#>
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        <#code#>
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        <#code#>
    }
    
    // searchbutton 누르면 화면에 검색 결과 + 히스토리 남기기
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mySearchTableViewCell") as? MySearchTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(data: mySearchs[indexPath.row], indexPathRow: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySearchs.count
    }
    
    // select 이벤트는 cell 안에 2개 이하의 클릭이벤트가 있을 때만 사용하기
    // cell 안에 이벤트가 많으면 이 함수를 사용하기 불편함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    func tableView
}
