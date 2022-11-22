//
//  MySearchViewController_ex.swift
//  Recody
//
//  Created by 마경미 on 11.11.22.
//

import Foundation
import UIKit

class SearchViewController: CommonVC, DataPassingType, ObservingTableCellEvent {
    var viewModel = MySearchViewModel()
    var tableList: [TableCellViewModel] = [TableCellViewModel]()
    var mySearchs: [String] = [
        "블랙핑크", "블랙팬서", "미움 받을 용기", "닥터스트레인지"
    ]
    
    var mySearchResults: [Work] = [
        Work(id: "1", name: "Black Panther", image: "1"),
        Work(id: "2", name: "블랙", image: "2"),
        Work(id: "3", name: "블랙스완", image: "3"),
        Work(id: "4", name: "블랙 위도우", image: "4")
    ]
    var filteredData: [String]!

    // 검색, 검색 취소, 비우기, 기록 삭제, 필터
    enum UseCase: Int, OrderType {
        case search = 100
        case cancelSearch = 101
        case empty = 102
        case delete = 103
        case filter = 104
        case history = 105
        var number: Int {
            return self.rawValue
        }
    }

    // outlet 연결 (검색 기능 활성화)
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

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

    func setUp() {
        searchView.addSubview(tableView)
    }

    // cell 클릭 시 검색 바로 이동
    // display 쪽에서 router 호출
    override func display(orderNumber: Int) {
//        guard let test = UseCase.init(rawValue: orderNumber) else { return } // search -> interactor가 받음
//        let worker = self.interactor?.just(UseCase.search) // worker가 반환
//        worker?.drop() // api 호출 x
//        // worker?.api(.) - api 호출

        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
        // search는 검색버튼 눌렀을 때 api 호출
        // filter는 누르면 modal창 띄우기
        case .filter:
//            self.router?.pushViewController(RoutingLogic.Navigation., dataStore: nil)
            break
        // 검색 취소는 searchDelegate에서 하기
        case .cancelSearch: break
        // delete는 cell 안에서
        case .delete: break
        case .empty: break
        case .history:
            // 검색 history api 호출 (success시에 하나?)
            guard let history = UseCase.init(rawValue: orderNumber) else { return }
            let worker = self.interactor?.just(UseCase.history)
//            worker?.api(<#T##command: ApiCommand##ApiCommand#>)
        default:
            break
        }
    }

    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
    }

    override func displayErorr(orderNumber: Int, msg: String?) {
    }

    func eventFromTableCell(code: Int) {
    }
}

struct MySearchViewModel {

}

// 이전에 필요한 것 -> 1. empty history view, 2. history view, 3. search view
// 처음에 필요한 것 -> 검색 히스토리 (삭제 가능) , 검색 히스토리가 없을 경우도 생각해보기

// 검색을 버튼 눌렀을 때만 업데이트할 것 인지, 타이핑할 때 마다 업데이트해야 할 것인지 서버팀과 상의하기 (기억속엔 전자였던 것 같음)
// 타이핑 중 search bar에 취소 버튼 나타나기
//extension SearchViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//        print(text)
//        self.data.filterValue = self.data.items.filter {
//            $0.localizedCaseInsensitiveContains(text)
//        }
//        searchBar.showsCancelButton = true
//        self.tableView.reloadData()
//    }
//}

//extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }
//    func willPresentSearchController(_ searchController: UISearchController) {
//        <#code#>
//    }
//
//    func willDismissSearchController(_ searchController: UISearchController) {
//        <#code#>
//    }
//
//    func didDismissSearchController(_ searchController: UISearchController) {
//        <#code#>
//    }
//
//    // searchbutton 누르면 화면에 검색 결과 + 히스토리 남기기
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
//        searchController.isActive = false
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = false
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//    }
//}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = mySearchs
        }

        for word in mySearchs {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredData.append(word)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mySearchTableViewCell") as? MySearchTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(data: mySearchs[indexPath.row], indexPathRow: indexPath.row)
        print(cell)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySearchs.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        let button = UIButton()

        headerView.addSubview(label)
        headerView.addSubview(button)

        return headerView
    }

    // select 이벤트는 cell 안에 2개 이하의 클릭이벤트가 있을 때만 사용하기
    // cell 안에 이벤트가 많으면 이 함수를 사용하기 불편함
    // select시 view 안의 화면을 tableview에서 collectionview로 바꾸기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mySearchResults.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workListCollectionViewCell", for: indexPath) as? WorkListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(with: mySearchResults[indexPath.row])
        return cell
    }
}
