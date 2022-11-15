//
//  CalendarViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/14.
//

import Foundation
import UIKit

class CalendarViewController : CommonVC, ObservingTableCellEvent {
    
    var viewModel = CalendarViewModel()
    var tableList : [TableCellViewModel] = [TableCellViewModel]()
    @IBOutlet weak var tableView: UITableView!
    enum CalendarTableCellType: Int {
        case week = 1
        var name: String {
            return CalendarWeekCell.Name
        }
    }
    enum UseCase: Int,OrderType {
        case some = 100
        var number: Int {
            return self.rawValue
        }
    }
    override func display(orderNumber: Int) {
        
    }
    override func displayErorr(orderNumber: Int, msg: String?) {
        
    }
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
        
    }
    //테이블 셀 클릭이벤트
    func eventFromTableCell(code: Int) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        self.router?.pushViewController(RoutingLogic.Navigation.home, dataStore: nil)
    }
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let registerCellList = [(CalendarWeekCell.Xib,
                                 CalendarWeekCell.Name)]
        tableView.register(cells: registerCellList)
        tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        
        tableView.reloadData()
    }
}

extension CalendarViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // visible 값에따라 숨기고 감추고가 가능합니다.
        let list = tableList.filter{ $0.visible }.count
        return list
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var list = self.tableList.filter{ $0.visible }
        var cell = UITableViewCell()
        
        guard let type = CalendarTableCellType(rawValue: list[indexPath.row].type) else { fatalError("CellType Int Out Of Bounds Error") }
        var mCell = tableView.dequeueReusableCell(withIdentifier: type.name) as? UITableViewCell & ObservingTableCell
            // Viewmodel 주입
            mCell?.viewmodel = list[indexPath.row]
            // Cell 내의 클릭이벤트 구독 -> eventFromTableCell() 함수로전달
            mCell?.eventDelegate = self
        
        if mCell != nil { cell = mCell! }
        list[indexPath.row].viewHeight = cell.frame.height
//        cell.contentView.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Row 별로 다양한 높이를 제공하기한 코드
        let list = self.tableList.filter{ $0.visible }
        return list[indexPath.row].viewHeight
//        return list[indexPath.row].viewHeight + 20
    }
}

class CalendarViewModel {
    
}


