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
        case some = 100
        case nextMonth = 101 //다음달
        case previousMonth = 102 //이전달
        case download = 103 //다운로드
        case setting = 104 //셋팅
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
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.navigationController?.isNavigationBarHidden = true
//        self.router?.pushViewController(RoutingLogic.Navigation.home, dataStore: nil)
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
    
    func update(){
        lbYear.text = "\(viewModel.currentYear)"
        lbMonth.text = "\(viewModel.currentMonth)"
        tableList.removeAll()
        for index in 1...viewModel.weekCount {
            
            tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: nil))
        }
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
    var currentYear = 0
    var currentMonth = 0
    var currentDay = 0
    //오늘 일수
    var days = [Int]()
    var startWeekDay = 0
    // 첫날이 무슨요일인지
    var lastDayCount = 0
    // 기본값 30 / 연 월이 선택되고 결정됨
    var weekCount = 0
    // 주의 수
    var recordImgs = [Int:String]()
    // key 날의수
    // value 해당 날짜에 가장 최근에 기록한 작품의 포스터 이미지 url 값
    var isStartSunday = true
    //첫주가 일요일로 시작 = true
    //첫주가 월요일로 시작 = false
    var lastWeekDayCount = 0
    //마지막 주 일수
    init() {
        let component = TimeUtil.nowDateComponent()
        self.currentYear = component.year!
        self.currentMonth = component.month!
        self.currentDay = component.day!
        updateState()
    }
    func nextMonth(){
        if self.currentMonth == 12 {
            self.currentMonth = 1
            self.currentYear += 1
        }else {
            self.currentMonth += 1
        }
        updateState()
    }
    func previousMonth(){
        if self.currentMonth == 1 {
            self.currentMonth = 12
            self.currentYear -= 1
        }else {
            self.currentMonth -= 1
        }
        updateState()
    }
    func updateState(){
        self.lastDayCount = TimeUtil.lastDayCount(currentYear, currentMonth)
        self.startWeekDay = TimeUtil.startWeekDayCount(currentYear, currentMonth)
        self.weekCount = TimeUtil.weekCountOfMonth(currentYear, currentMonth)
        self.lastWeekDayCount = TimeUtil.lastWeekDayCount(currentYear, currentMonth)
        self.days = [Int]()
        for index in 1...self.lastDayCount {
            days.append(index)
        }
        print(self.currentYear)
        print(self.currentMonth)
        print(self.currentDay)
        print(lastDayCount)
        print(startWeekDay)
        print(weekCount)
        print(lastWeekDayCount)
        print(days)
    }
}


