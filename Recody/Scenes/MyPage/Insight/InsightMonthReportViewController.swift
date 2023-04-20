//
//  InsightMonthReportViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/20.
//

import Foundation
import UIKit

class InsightMonthReportViewController: CommonVC {
 
    var viewModel = InsightMonthReportViewModel()
    var tableList: [TableCellViewModel] = [TableCellViewModel]()
    // 화면내의 모든 인터렉션 (탭,스와이프, 롱탭, .... 의 수만큼 작성필요)
    enum UserCace: Int, OrderType {
        case back = 100
        case nextMonth = 101
        case previousMonth = 102
        case cellClickEvent = 103
        case download = 104
        case hambuger = 105
        var number: Int {
            return self.rawValue
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    func bind(_ data: DataStoreType) {
    }
    func routing(orderNumber: Int) {
        if orderNumber == 1 {
            
        } else {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpTableView()
    }
    func setup(){
        btnBack.tag = UserCace.back.number
        [btnBack].forEach({
            $0?.setTitle("", for: .normal)
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnClickEvent)))
        })
        
    }
    @objc func btnClickEvent(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            if let command = UserCace.init(rawValue: tag) {
                self.interactor?.just(command).drop()  // 바로 UI를 업데이트 할경우
            }
        }
    }
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
        if let command = UserCace.init(rawValue: orderNumber) {
            switch command {
 
//            case .cellClickEvent:
//                if let reuslt = dataStore?.data(command)?.fetch(ChildDataModel.self) {
//                    print(reuslt.message)
//                    print(reuslt.data)
//                }
            default:
                print("Router 커맨드 : \(command)")
            }
        }
    }
    override func displayErorr(orderNumber: Int, msg: String?) {
        if let command = UserCace.init(rawValue: orderNumber) {
            switch command {
            default:
                print("에러발생 커맨드 : \(command)")
            }
        }
    }
    
    override func display(orderNumber: Int) {
        if let command = UserCace.init(rawValue: orderNumber) {
            switch command {
            case .back:
                self.router?.popViewContoller(animated: true)
            default:
                print("처리안된 커맨드 : \(command)")
            }
        }
    }
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10.0
        tableView.contentInset.bottom = 20.0
        tableView.reloadData()
    }
}

extension InsightMonthReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
 
}
struct InsightMonthReportViewModel {
//    var nickName: String = ""
//    var currentMonth: Int = 1
//    var seenWorks: Int = 0
//    var recordCount: Int = 0
}
