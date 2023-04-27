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

class SearchViewController: UIViewController, ObservingTableCellEvent {
    var viewModel = MySearchViewModel()
    var tableList: [TableCellViewModel] = [TableCellViewModel]()
    var filterKeyword = ""
    var mySearchResults: [Work] = [
        Work(id: "1", name: "Black Panther", image: "1"),
        Work(id: "2", name: "블랙", image: "2"),
        Work(id: "3", name: "블랙스완", image: "3"),
        Work(id: "4", name: "블랙 위도우", image: "4")
    ]
    var filteredData: [String]!
    
    // 검색, 검색 취소, 비우기, 기록 삭제, 필터
    enum UseCase: Int {
        case search = 100
        case cancelSearch = 101
        case empty = 102
        case delete = 103
        case filter = 104
        case history = 105
        case pushResulSearch = 106
        case backToTap = 107
        var number: Int {
            return self.rawValue
        }
    }

    // outlet 연결 (검색 기능 활성화)
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backToTap: UIBarButtonItem!
    
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
    static func getInstanse() -> SearchViewController{
        guard let vc =  UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "addRecord") as? SearchViewController
        else {
            fatalError()
        }
        return vc
    }
    func setUp() {
        self.navigationItem.titleView = searchBar
        backToTap.tag = 107
        backToTap.action = #selector(barBtnClickEvent)
        backToTap.target = self
        
        viewModel.list = ["에이핑크","소녀시대","블랙핑크","AOA","르세라핌"]
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        tableView.register(MySearchTableViewCell.Xib, forCellReuseIdentifier: MySearchTableViewCell.Name)
    }
    @objc func barBtnClickEvent(_ sender:UIBarButtonItem){
        guard let useCase = UseCase(rawValue: sender.tag) else { return }
        switch useCase {
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
//            worker?.api(<#T##command: ApiCommand##ApiCommand#>)
        break
        case .backToTap:
//            self.router?.tabbarMovePreviousPage(nil)
            if let tabbar = self.tabBarController {
                if let tabbarVC = (tabbar as? TabBarController){
                    tabbarVC.selectedIndex = tabbarVC.previousTabIndex
                }
            }
        default:
            break
        }
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            guard let useCase = UseCase(rawValue: tag) else { return }
            // search는 검색버튼 눌렀을 때 api 호출
            // filter는 누르면 modal창 띄우기
            switch useCase {
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
    //            worker?.api(<#T##command: ApiCommand##ApiCommand#>)
            break
            case .backToTap:
//                self.router?.tabbarMovePreviousPage(nil)
                if let tabbar = self.tabBarController {
                    if let tabbarVC = (tabbar as? TabBarController){
                        tabbarVC.selectedIndex = tabbarVC.previousTabIndex
                    }
                }
             
            default:
                break
            }
        }
    }

    func eventFromTableCell(code: Int, index: Int) {
        guard let cellEvent = MySearchTableViewCellEvent(rawValue: code) else { return }
        switch cellEvent {
        case .select:
            print("select \(index)")
        case .delete:
            print("delete \(index)")
            // 삭제시
            // 여기서 index는 tableList의 index를 의미함
            // tableList 는 viewmodel의 list를 filterKeyword로 필터링하여 생성된 tablecell의 data model임
            // viewmodel의 list 에서 delete 한후에 update() 를 해야함
            if let contentName = tableList[index].data?.stringValue(key: "workName") {
                var removeIndex = -1
                for index in 0...viewModel.list.count-1  where viewModel.list[index] == contentName {
                        removeIndex = index
                }
                if removeIndex != -1 {
                    viewModel.list.remove(at: removeIndex)
                }
            }
        }
        update()
    }
    func update() {
        // Data 바인딩
        // VC.ViewModel 기본형 데이터가 있어야함
        // tableList는 ViewModel.list를 fillterKeyword로 필터된 리스트를 재료로 생성해야함
        // update() 함수는 viewModel을 재료로 화면에 data를 바인딩하는 개념으로만 사용해야함
        // 그외 비지니스 로직도 viewModel의 상태값들을 갱신하여 update() 호출을 통해 다시 바인딩 해야함.
        // Api통신을 할때도 리스폰을 받은뒤 그것으로 상태값을 갱신하고 update() 호출하여 바인딩 해야함.
        let list = viewModel.filterKeyword == "" ? viewModel.list : viewModel.list.filter({ $0.contains(viewModel.filterKeyword)})
        if list.count > 0 {
            tableList = (0...list.count-1).map({ index -> TableCellViewModel in
                let viewmodel = TableCellViewModel(type: index, data: ["workName": list[index]])
                viewmodel.index = index
                return viewmodel
            })
        } else {
            tableList.removeAll()
        }
        tableView.reloadData()
//        for (index,name) in list.enumerated() {
//            tableList.append(TableCellViewModel(type: index, data: ["keyword":name]))
//        }
        
    }
    // cell 클릭 시 검색 바로 이동
    // display 쪽에서 router 호출
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterKeyword = searchText
        update()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.router?.pushViewController(RoutingLogic.Navigation.searchResult, dataStore: nil)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = tableList.filter({$0.visible})
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

    // select 이벤트는 cell 안에 2개 이하의 클릭이벤트가 있을 때만 사용하기
    // cell 안에 이벤트가 많으면 이 함수를 사용하기 불편함
    // select시 view 안의 화면을 tableview에서 collectionview로 바꾸기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       return
    }
}
