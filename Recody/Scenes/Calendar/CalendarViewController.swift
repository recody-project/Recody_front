//
//  CalendarViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/14.
//

import Foundation
import UIKit

class CalendarViewController: CommonVC, ObservingTableCellEvent {
    var viewModel = CalendarViewModel()
    var tableList : [TableCellViewModel] = [TableCellViewModel]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var btnNextMonth: UIButton!
    @IBOutlet weak var btnPreviousMonth: UIButton!
    enum CalendarTableCellType: Int {
        case week = 1
        var name: String {
            return CalendarWeekCell.Name
        }
    }
    enum UseCase: Int,OrderType {
        case moveDetail = 100
        case nextMonth = 101 // 다음달
        case previousMonth = 102 // 이전달
        case download = 103 // 다운로드
        case setting = 104 // 셋팅
        var number: Int {
            return self.rawValue
        }
    }
    override func display(orderNumber: Int) { //  self.interactor?.just(useCase).drop() 시 받는콜백
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
            switch useCase {
            case .nextMonth:
                self.viewModel.nextMonth()
            break
            case .previousMonth:
                self.viewModel.previousMonth()
            break
            default:
            break
            }
            update()
    }
    override func displayErorr(orderNumber: Int, msg: String?) {
    }
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
    }
    //테이블 셀 클릭이벤트
    func eventFromTableCell(code: Int) {
//        self.interactor?.just(UseCase.moveDetail).api(.checkValidEmail("asd"))
        self.router?.pushViewController(RoutingLogic.Navigation.calendarDetail, dataStore: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setup()
        self.navigationController?.isNavigationBarHidden = true
//        self.router?.pushViewController(RoutingLogic.Navigation.home, dataStore: nil)
        update()
    }
    func setup(){
        btnNextMonth.setTitle("", for: .normal)
        btnPreviousMonth.setTitle("", for: .normal)
        btnNextMonth.tag = UseCase.nextMonth.number
        btnPreviousMonth.tag = UseCase.previousMonth.number
        btnNextMonth.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnPreviousMonth.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer){
        guard let tag = sender.view?.tag else { return }
        guard let useCase = UseCase(rawValue: tag) else { print("clickEvent : 등록안된 TAG = \(tag)"); return }
        switch useCase {
            default:
                self.interactor?.just(useCase).drop()
                break
        }
    }
  
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        let registerCellList = [(CalendarWeekCell.Xib,
                                 CalendarWeekCell.Name)]
        tableView.register(cells: registerCellList)
        tableView.reloadData()
    }
    
    func update(){
        lbYear.text = "\(viewModel.selectYear)"
        lbMonth.text = "\(viewModel.selectMonth)"
        tableList.removeAll()
        viewModel.weeks.forEach({ week in
            tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: ["week":week,
                                                                                                  "month":viewModel.selectMonth,
                                                                                                  "year":viewModel.selectYear]))
        })
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



