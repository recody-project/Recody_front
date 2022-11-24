//
//  TableCellViewModel+.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/31.
//

import Foundation
import UIKit
//MARK: - TableCellViewModel / Cell의 상태값을 담당함 viewmodel.delegate <-구독- cell
class TableCellViewModel {
    init(type : Int,data : Dictionary<String,Any>?){
        self.type = type
        self.data = data
    }
    var type : Int = -1
    var index : Int = -1
    var visible : Bool = true
    var delegate : TableCellDelegate? {
        didSet {
            delegate?.changeData()
        }
    }
    var viewHeight : Double = 50.0
    var data : Dictionary<String,Any>? {
        willSet {
            delegate?.changeData()
        }
    }
}
protocol TableCellDelegate {
    // changeData()
    // TableCellViewModel 의 상태값이 갱신되면 호출됨
    func changeData()
}
//MARK: - ObservingTableCell viewmodel을 구독하고 / 최상위 VC에 이벤트를 전달하기위함
protocol ObservingTableCell: TableCellDelegate {
    var viewmodel: TableCellViewModel? { get set }
    // TableCellViewModel
    // ViewModel 이 갱신될떄마다 changeData 함수가 호출됩니다.
    // Cell은 viewmodel.delegate를 구독하고있어야합니다.
    var cellView: UIView? { get set }
    // cellView
    // Cell의 ContentView 가 아닙니다.
    // 실제 커스텀 UI의 최상위 View 로 해주세요 (IBOutlet 권장)
    var eventDelegate: ObservingTableCellEvent? { get set }
    // eventDelegate
    // VC에 이벤트를 전달하는 protocol
    func binding(data: Dictionary<String, Any>)
    // binding(_)
    // TableCellDelegate.changeData 함수내에서 TableCellViewModel.data를 언래핑한다음에 호출해주세요
    // binding 함수에서 데이터를 View에 전달해주면됩니다.
    func sendEventToController(sender: UITapGestureRecognizer)
    // sendEventToController(_)
    // Cell 내의 모든 뷰들의 클릭 이벤트를 이쪽으로 연결해주세요.
    // 이벤트간의 구분은 sender.view.tag 로 접근합니다.
    // 이 함수내에서 아래의 코드를 호출해주시면 ViewController의 eventFromTableCell 함수로 전달됩니다. ( VC에서 ObservingTableCellEvent를 상속받아야함 )
    // eventDelegate?.eventFromTableCell(code: tag)
}
//MARK: - VC에서 Cell의 이벤트를 전달받는 함수
protocol ObservingTableCellEvent {
    func eventFromTableCell(code: Int,index:Int)
}
//MARK: - 편의성 UITableViewCell 등록관련
//TableView에 셀을 등록하기 편하게 하기위해
protocol IdentifiableTableCell {
    static var Name: String { get }
    static var Xib: UINib { get }
}
extension UITableViewCell: IdentifiableTableCell {
    static var Name: String {
        return String(describing: Self.self)
    }
    static var Xib: UINib {
        return UINib(nibName: self.Name, bundle: nil)
    }
}
extension UITableView {
    func register(cells: [(UINib, String)]) {
        cells.forEach({ cell in
            self.register(cell.0, forCellReuseIdentifier: cell.1)
        })
    }
}
