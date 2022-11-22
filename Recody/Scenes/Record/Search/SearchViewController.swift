//
//  MySearchViewController_ex.swift
//  Recody
//
//  Created by 마경미 on 11.11.22.
//

import Foundation
import UIKit
import SnapKit

struct MySearchViewModel {
    var list = [String]()
    var filterKeyword = ""
}

class SearchViewController: CommonVC, DataPassingType, ObservingTableCellEvent {
    var viewModel = MySearchViewModel()
    var tableList: [TableCellViewModel] = [TableCellViewModel]()
    var mySearchs: [String] = [
        "블랙핑크", "블랙팬서", "미움 받을 용기", "닥터스트레인지"
    ]
    var filterKeyword = ""
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
        update()
    }
    func setUp() {
        viewModel.list = ["에이핑크","소녀시대","블랙핑크","AOA","라세라핌"]
        tableView.register(MySearchTableViewCell.Xib, forCellReuseIdentifier: MySearchTableViewCell.Name)
        searchView.addSubview(tableView)
    }
    func eventFromTableCell(code: Int, index: Int) {
        guard let cellEvent = MySearchTableViewCellEvent(rawValue: code) else { return }
        switch cellEvent {
            case .select:
            print("select \(index)")
            break
            case .delete:
            print("delete \(index)")
            //삭제시
            //여기서 index는 tableList의 index를 의미함
            //tableList 는 viewmodel의 list를 filterKeyword로 필터링하여 생성된 tablecell의 data model임
            //viewmodel의 list 에서 delete 한후에 update() 를 해야함
            if let contentName = tableList[index].data?.stringValue(key: "workName") {
                var removeIndex = -1
                for index in 0...viewModel.list.count-1 {
                    if viewModel.list[index] == contentName {
                        removeIndex = index
                    }
                }
                if removeIndex != -1 {
                    viewModel.list.remove(at: removeIndex)
                }
            }
            break
        }
        update()
    }
    func update(){
        //Data 바인딩
        // VC.ViewModel 기본형 데이터가 있어야함
        // tableList는 ViewModel.list를 fillterKeyword로 필터된 리스트를 재료로 생성해야함
        // update() 함수는 viewModel을 재료로 화면에 data를 바인딩하는 개념으로만 사용해야함
        // 그외 비지니스 로직도 viewModel의 상태값들을 갱신하여 update() 호출을 통해 다시 바인딩 해야함.
        // Api통신을 할때도 리스폰을 받은뒤 그것으로 상태값을 갱신하고 update() 호출하여 바인딩 해야함.
        let list = viewModel.filterKeyword == "" ? viewModel.list : viewModel.list.filter({ $0.contains(viewModel.filterKeyword)})
        if list.count > 0 {
            tableList = (0...list.count-1).map({ index -> TableCellViewModel in
                let viewmodel = TableCellViewModel(type: index, data: ["workName":list[index]])
                viewmodel.index = index
                return viewmodel
            })
        }else{
            tableList.removeAll()
        }
        tableView.reloadData()
//        for (index,name) in list.enumerated() {
//            tableList.append(TableCellViewModel(type: index, data: ["keyword":name]))
//        }
        
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
        viewModel.filterKeyword = searchText
        update()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var list = tableList.filter({$0.visible})
        var cell = UITableViewCell()
        var mCell = tableView.dequeueReusableCell(withIdentifier: MySearchTableViewCell.Name) as? UITableViewCell & ObservingTableCell
            // Viewmodel 주입
            mCell?.viewmodel = list[indexPath.row]
            // Cell 내의 클릭이벤트 구독 -> eventFromTableCell() 함수로전달
            mCell?.eventDelegate = self
        if mCell != nil { cell = mCell! }
        list[indexPath.row].viewHeight = cell.frame.height
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.filter({$0.visible}).count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        let button = UIButton()
        headerView.addSubview(label)
        headerView.addSubview(button)
        label.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
        label.textColor = .white
        label.text = "헤더라벨" 
        button.snp.makeConstraints({
            $0.left.equalTo(label.snp.right).offset(8.0)
            $0.centerY.equalToSuperview()
        })
        button.setTitle("버튼", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    // select 이벤트는 cell 안에 2개 이하의 클릭이벤트가 있을 때만 사용하기
    // cell 안에 이벤트가 많으면 이 함수를 사용하기 불편함
    // select시 view 안의 화면을 tableview에서 collectionview로 바꾸기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       return
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
