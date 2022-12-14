//
//  CollectionViewModel+.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/28.
//

import Foundation
import UIKit
//MARK: - CollectionCellViewModel / Cell의 상태값을 담당함 viewmodel.delegate <-구독- cell
class CollectionCellViewModel {
    init(type : Int,data : Dictionary<String,Any>?){
        self.type = type
        self.data = data
    }
    // type : 사용하는 Cell의 수가 복수일 경우 ID 값으로 사용
    var type : Int = -1
    // index 값은 데이터 Array 상의 index를 의미함
    var index : Int = -1
    var visible : Bool = true
    var delegate : CollectionCellDelegate? {
        didSet {
            delegate?.changeData()
        }
    }
    var viewHeight : Double = 50.0
    var viewWidth : Double = 100.0
    var data : Dictionary<String,Any>? {
        willSet {
            delegate?.changeData()
        }
    }
}
protocol CollectionCellDelegate {
    // changeData()
    // CollectionCellViewModel 의 상태값이 갱신되면 호출됨
    func changeData()
}
//MARK: - ObservingTableCell viewmodel을 구독하고 / 최상위 VC에 이벤트를 전달하기위함
protocol ObservingCollectionCell: CollectionCellDelegate {
    var viewmodel: CollectionCellViewModel? { get set }
    // TableCellViewModel
    // ViewModel 이 갱신될떄마다 changeData 함수가 호출됩니다.
    // Cell은 viewmodel.delegate를 구독하고있어야합니다.
    var cellView: UIView? { get set }
    // cellView
    // Cell의 ContentView 가 아닙니다.
    // 실제 커스텀 UI의 최상위 View 로 해주세요 (IBOutlet 권장)
    var eventDelegate: ObservingCollectionCellEvent? { get set }
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
protocol ObservingCollectionCellEvent {
    // index : dataList 상의 index
    // row : 가로의 몇번쨰인가
    // code : Action Code
    func eventFromTableCell(code: Int,index:Int)
}

extension UICollectionViewCell: IdentifiableTableCell {
    static var Name: String {
        return String(describing: Self.self)
    }
    static var Xib: UINib {
        return UINib(nibName: self.Name, bundle: nil)
    }
}
extension UICollectionView {
    func register(cells: [(UINib, String)]) {
        cells.forEach({ cell in
            self.register(cell.0, forCellWithReuseIdentifier: cell.1)
        })
    }
}
