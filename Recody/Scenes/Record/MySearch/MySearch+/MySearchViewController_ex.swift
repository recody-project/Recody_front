////
////  MySearchViewController_ex.swift
////  Recody
////
////  Created by 마경미 on 11.11.22.
////
//
//import Foundation
//import UIKit
//
//class MySearchViewController: CommonVC, DataPassingType, ObservingTableCellEvent {
//    func eventFromTableCell(code: Int) {
//        guard let cellEvent = SearchCellEvent() else { return }
//    }
//    var viewModel = MySearchViewModel()
//    var tableList: [TableCellViewModel] = [TableCellViewModel]()
//
// 검색, 검색 취소, 비우기, 기록 삭제, 필터
//    enum UserCase: Int, OrderType {
//        case
//        var number: Int {
//            return self.rawValue
//        }
//    }
//
// outlet 연결 (검색 기능 활성화)
//


// cell 클릭 시 검색 바로 이동
//    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
//        if let command = UserCase.init(rawValue: orderNumber) {
//            switch command {
//            case
//            }
//        }
//    }
//
//    override func displayErorr(orderNumber: Int, msg: String?) {
//        <#code#>
//    }
//
//    override func display(orderNumber: Int) {
//        <#code#>
//    }
//}
//
//struct MySearchViewModel {
//
//}


// 이전에 필요한 것 -> 1. empty history view, 2. history view, 3. search view
// 처음에 필요한 것 -> 검색 히스토리 (삭제 가능) , 검색 히스토리가 없을 경우도 생각해보기

