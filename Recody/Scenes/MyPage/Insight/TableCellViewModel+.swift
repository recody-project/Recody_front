//
//  TableCellViewModel+.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/31.
//

import Foundation
import UIKit

class TableCellViewModel {
    init(type : Int,data : Dictionary<String,Any>?){
        self.type = type
        self.data = data
    }
    var type : Int = -1
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
    func changeData()
}
protocol ObservingTableCell: TableCellDelegate {
    var viewmodel: TableCellViewModel? { get set }
    var cellView: UIView? { get set }
    var eventDelegate: ObservingTableCellEvent? { get set }
    func binding(data: Dictionary<String, Any>)
    func sendEventToController(sender: UITapGestureRecognizer)
}
protocol ObservingTableCellEvent {
    func eventFromTableCell(code: Int)
}
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
