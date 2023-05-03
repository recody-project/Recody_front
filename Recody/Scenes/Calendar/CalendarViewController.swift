//
//  CalendarViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/14.
//

import Foundation
import UIKit

class CalendarViewController: UIViewController, CalendarWeekCellDelegate {
    var viewModel = CalendarViewModel()
    var tableList: [TableCellViewModel] = [TableCellViewModel]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var btnNextMonth: UIButton!
    @IBOutlet weak var btnPreviousMonth: UIButton!
    @IBOutlet weak var imgSetting: UIImageView!
    @IBOutlet weak var imgDonwload: UIImageView!
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
        case insight = 104 // 인사이트
        var number: Int {
            return self.rawValue
        }
    }
    func selectDay(dateStr: String) {
        let vc = CalendarDetailViewController.getInstanse()
        vc.viewModel.date = Date(dateStr)
        self.navigationController?.pushViewController(vc, animated: true)
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
        btnNextMonth.tag = UseCase.nextMonth.rawValue
        btnPreviousMonth.tag = UseCase.previousMonth.rawValue
        imgSetting.isUserInteractionEnabled = true
        imgDonwload.isUserInteractionEnabled = true
        imgSetting.tag = UseCase.insight.rawValue
        imgDonwload.tag = UseCase.download.rawValue
        [imgSetting, imgDonwload, btnNextMonth, btnPreviousMonth].forEach({
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        })
        
        self.viewModel.recordImgs[1] = "common (1)"
        self.viewModel.recordImgs[11] = "common (2)"
        self.viewModel.recordImgs[15] = "common (3)"
        self.viewModel.recordImgs[16] = "common (4)"
        self.viewModel.recordImgs[20] = "common (1)"
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer){
        guard let tag = sender.view?.tag else { return }
        guard let useCase = UseCase(rawValue: tag) else { print("clickEvent : 등록안된 TAG = \(tag)"); return }
        switch useCase {
        case .nextMonth:
            self.viewModel.nextMonth()
        break
        case .previousMonth:
            self.viewModel.previousMonth()
        break
//            case .download:
//                self.present(SomeViewController(), animated: true)
        break
        case .insight:
            self.navigationController?.pushViewController(InsightViewController.getInstanse(), animated: true)
        break
        default:
        break
        }
        update()
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
            tableList.append(TableCellViewModel(type: CalendarTableCellType.week.rawValue, data: ["week": week,
                                                                                                  "month": viewModel.selectMonth,
                                                                                                  "year": viewModel.selectYear,
                                                                                                  "img":viewModel.recordImgs]))
        })
        tableView.reloadData()
    }
}
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // visible 값에따라 숨기고 감추고가 가능합니다.
        let list = tableList.filter { $0.visible }.count
        return list
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = self.tableList.filter { $0.visible }
        var cell = UITableViewCell()
        guard let type = CalendarTableCellType(rawValue: list[indexPath.row].type) else { fatalError("CellType Int Out Of Bounds Error") }
        var mCell = tableView.dequeueReusableCell(withIdentifier: type.name) as? CalendarWeekCell
            // Viewmodel 주입
            mCell?.viewmodel = list[indexPath.row]
            // Cell 내의 클릭이벤트 구독 -> eventFromTableCell() 함수로전달
            mCell?.delegate = self
        if mCell != nil { cell = mCell! }
        list[indexPath.row].viewHeight = cell.frame.height
//        cell.contentView.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Row 별로 다양한 높이를 제공하기한 코드
        let list = self.tableList.filter { $0.visible }
        return list[indexPath.row].viewHeight
//        return list[indexPath.row].viewHeight + 20
    }
}
