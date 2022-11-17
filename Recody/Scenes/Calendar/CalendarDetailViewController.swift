//
//  CalendarDetailViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/17.
// CalendarViewController에서 포스터를 클릭시 이동하는 화면

import Foundation
import UIKit
class CalendarDetailViewController: CommonVC, ObservingTableCellEvent {
    var viewModel = CalendarViewModel()
    var tableList : [TableCellViewModel] = [TableCellViewModel]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    enum CalendarDetailTableCellType: Int {
        case work = 1
        var name: String {
            return CalendarDetailCell.Name
        }
    }
    enum UseCase : Int,OrderType {
        case back = 100
        var number: Int {
            return self.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpTableView()
    }
    override func display(orderNumber: Int) {
        guard let useCase = UseCase.init(rawValue: orderNumber) else { return }
        switch useCase {
            case .back:
                self.navigationController?.popViewController(animated: true)
            default:
                break
        }
    }
    func setup(){
        btnBack.setTitle("", for: .normal)
        btnBack.tag = UseCase.back.rawValue
        btnBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            guard let useCase = UseCase.init(rawValue: tag) else { return }
            self.interactor?.just(useCase).drop()
        }
    }
    func setUpTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        let registerCellList = [(CalendarDetailCell.Xib,
                                 CalendarDetailCell.Name)]
        tableView.register(cells: registerCellList)
        tableList.append(TableCellViewModel(type: CalendarDetailTableCellType.work.rawValue, data: ["score":8,
                                                                                                    "genre":"영화",
                                                                                                    "workTitle":"1987"]))
        tableList.append(TableCellViewModel(type: CalendarDetailTableCellType.work.rawValue, data: ["score":6,
                                                                                                    "genre":"책",
                                                                                                    "workTitle":"1987"]))
        tableList.append(TableCellViewModel(type: CalendarDetailTableCellType.work.rawValue, data: ["score":7,
                                                                                                    "genre":"뮤지컬",
                                                                                                    "workTitle":"1987"]))
        tableList.append(TableCellViewModel(type: CalendarDetailTableCellType.work.rawValue, data: ["score":4,
                                                                                                    "genre":"드라마",
                                                                                                    "workTitle":"1987"]))
        tableList.append(TableCellViewModel(type: CalendarDetailTableCellType.work.rawValue, data: ["score":5,
                                                                                                    "genre":"연극",
                                                                                                    "workTitle":"1987"]))
        tableView.reloadData()
    }
    func eventFromTableCell(code: Int) {
    }
}
extension CalendarDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // visible 값에따라 숨기고 감추고가 가능합니다.
        let list = tableList.filter{ $0.visible }.count
        return list
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var list = self.tableList.filter{ $0.visible }
        var cell = UITableViewCell()
        guard let type = CalendarDetailTableCellType(rawValue: list[indexPath.row].type) else { fatalError("CellType Int Out Of Bounds Error") }
        var mCell = tableView.dequeueReusableCell(withIdentifier: type.name) as? UITableViewCell & ObservingTableCell
            // Viewmodel 주입
            mCell?.viewmodel = list[indexPath.row]
            // Cell 내의 클릭이벤트 구독 -> eventFromTableCell() 함수로전달
            mCell?.eventDelegate = self
            mCell?.cellView?.clipsToBounds = true
            mCell?.cellView?.borderWidth = 1.0
        mCell?.cellView?.layer.borderColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.5).cgColor
            mCell?.cellView?.backgroundColor = UIColor(hexString: "#FFFFFF")
            mCell?.cellView?.layer.cornerRadius = 15
        
        if mCell != nil { cell = mCell! }
        list[indexPath.row].viewHeight = cell.frame.height
//        cell.contentView.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Row 별로 다양한 높이를 제공하기한 코드
        let list = self.tableList.filter{ $0.visible }
//        return list[indexPath.row].viewHeight
        return list[indexPath.row].viewHeight + 20
    }
}
class CalendarDetailViewModel {
    
}
