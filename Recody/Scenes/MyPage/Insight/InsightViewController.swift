//
//  InsiteViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/27.
//

import Foundation
import UIKit

class InsightViewController : CommonVC,DataPassingType, ObservingTableCellEvent {
    func eventFromTableCell(code: Int) {
        //셀 내의 개별적 제스쳐 이벤트를 처리하는 공간
        //interactor를 통해서 처리
        guard let cellEvent = InsightCellEvent(rawValue: code) else { return }
        print(cellEvent)
//        self.interactor?.just(UserCace.cellClickEvent).drop()
    }
    var viewModel = InsiteViewModel()
    var tableList : [TableCellViewModel] = [TableCellViewModel]()
    //화면내의 모든 인터렉션 (탭,스와이프, 롱탭, .... 의 수만큼 작성필요)
    enum UserCace : Int,OrderType{
        case nextMonth = 101
        case previousMonth = 102
        case cellClickEvent = 103
        var number: Int {
            return self.rawValue
        }
    }
     
    enum InsiteCellType : Int {
        case statistics = 1
        case statisticsGraph = 2
        case mostImpressive = 3
        case top3Genre = 4
        case firstRecord = 5
        case hallOfFame = 6
        case myRank = 7
        case mostAppreciation = 8
        case mostAppreciationAll = 9
        case share = 10
        var name : String {
            switch self {
            case .statistics:
                return InsightStatisticsCell.Name
            case .statisticsGraph:
                return InsightStatisticsGraphCell.Name
            case .mostImpressive:
                return InsightMostImpressiveCell.Name
            case .top3Genre:
                return InsightTop3GenreCell.Name
            case .firstRecord:
                return InsightFirstRecordCell.Name
            case .hallOfFame:
                return InsightHallOfFameCell.Name
            case .myRank:
                return InsightMyRankCell.Name
            case .mostAppreciation:
                return InsightMostAppreciationCell.Name
            case .mostAppreciationAll:
                return InsightAllUserMostAppreciationCell.Name
            case .share:
                return InsightShareCell.Name
            }
        }
    }
    
    @IBOutlet weak var lBNickName:UILabel!
    @IBOutlet weak var lBMonthCount:UILabel!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var btnPrevious:UIButton!
    @IBOutlet weak var btnNext:UIButton!
    func bind(_ data: DataStoreType) {
        
    }
    func routing(orderNumber : Int){
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
        btnNext.tag = UserCace.nextMonth.number
        btnPrevious.tag = UserCace.previousMonth.number
        [btnNext,btnPrevious].forEach({
            $0?.setTitle("", for: .normal)
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnClickEvent)))
        })
        
    }
    @objc func btnClickEvent(_ sender : UITapGestureRecognizer){
        if let tag = sender.view?.tag {
            if let command = UserCace.init(rawValue: tag) {
//                self.interactor?.just(command).drop()  // 바로 UI를 업데이트 할경우
                self.interactor?.just(command).api(.checkValidEmail("ikmujn5@naver.com"))
            }
        }
    }
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
        if let command = UserCace.init(rawValue: orderNumber) {
            switch command {
                case .cellClickEvent:
                    if let reuslt = dataStore?.data(command)?.fetch(ChildDataModel.self) {
                        print(reuslt.message)
                        print(reuslt.data)
                    }
                    break
                default:
                    print("Router 커맨드 : \(command)")
                    break
            }
        }
    }
    override func displayErorr(orderNumber: Int, msg: String?) {
        if let command = UserCace.init(rawValue: orderNumber) {
            switch command {
                default:
                    print("에러발생 커맨드 : \(command)")
                    break
            }
        }
    }
    
    override func display(orderNumber: Int) {
        if let command = UserCace.init(rawValue: orderNumber) {
            switch command {
                case .nextMonth:
                    self.router?.present(RoutingLogic.Navigation.home, nil)
                    break
                case .previousMonth:
                    break
                default:
                    print("처리안된 커맨드 : \(command)")
                    break
            }
        }
    }
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let registerCellList = [(InsightStatisticsCell.Xib,
                                 InsightStatisticsCell.Name),
                                (InsightStatisticsGraphCell.Xib,
                                 InsightStatisticsGraphCell.Name),
                                (InsightMostImpressiveCell.Xib,
                                 InsightMostImpressiveCell.Name),
                                (InsightTop3GenreCell.Xib,
                                 InsightTop3GenreCell.Name),
                                (InsightFirstRecordCell.Xib,
                                 InsightFirstRecordCell.Name),
                                (InsightHallOfFameCell.Xib,
                                 InsightHallOfFameCell.Name),
                                (InsightMyRankCell.Xib,
                                 InsightMyRankCell.Name),
                                (InsightMostAppreciationCell.Xib,
                                 InsightMostAppreciationCell.Name),
                                (InsightAllUserMostAppreciationCell.Xib,
                                 InsightAllUserMostAppreciationCell.Name),
                                (InsightShareCell.Xib,
                                 InsightShareCell.Name)]
        self.tableView.register(cells:registerCellList)
        // 현재를 데이터가 없어서 Dictionary형태로 제공되고있지만 추후에는 VC의 Viewmodel을 전달하도록 할 계획입니다.
        tableList.append(TableCellViewModel(type: InsiteCellType.statistics.rawValue,
                                            data: ["nickName":"닉네임",
                                                   "month":"9",
                                                   "workCount":"99",
                                                   "recordCount":"999"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.statisticsGraph.rawValue,
                                            data: ["temp":""]))
        tableList.append(TableCellViewModel(type: InsiteCellType.mostImpressive.rawValue,
                                            data: ["month":"9",
                                                   "genre":"영화",
                                                   "workTitle":"1987",
                                                   "recordCount":"900"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.top3Genre.rawValue,
                                            data: ["top1":"코미디",
                                                   "top2":"로맨스 코미디",
                                                   "top3":"액션"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.firstRecord.rawValue,
                                            data: ["nickName":"코미디",
                                                   "month":"10",
                                                   "genre":"액션",
                                                   "workTitle":"오만과 편견"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.hallOfFame.rawValue,
                                            data: ["nickName":"영화가젤좋아",
                                                   "month":"9"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.myRank.rawValue,
                                            data: ["nickName":"영화가젤좋아",
                                                   "month":"9",
                                                   "score":9]))
        tableList.append(TableCellViewModel(type: InsiteCellType.mostAppreciation.rawValue,
                                            data: ["month":"9",
                                                   "workTitle":"1987"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.mostAppreciationAll.rawValue,
                                            data: ["genre":"영화",
                                                   "workTitle":"1987"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.share.rawValue, data: nil))
        // Padding 값
        tableView.contentInset.top = 10.0
        tableView.contentInset.bottom = 20.0
        tableView.reloadData()
    }
}

extension InsightViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // visible 값에따라 숨기고 감추고가 가능합니다.
        let list = tableList.filter{ $0.visible }.count
        return list
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var list = self.tableList.filter{ $0.visible }
        var cell = UITableViewCell()
        
        guard let type = InsiteCellType(rawValue: list[indexPath.row].type) else { fatalError("CellType Int Out Of Bounds Error") }
        var mCell = tableView.dequeueReusableCell(withIdentifier: type.name) as? UITableViewCell & ObservingTableCell
            // Viewmodel 주입
            mCell?.viewmodel = list[indexPath.row]
            // Cell 내의 클릭이벤트 구독 -> eventFromTableCell() 함수로전달
            mCell?.eventDelegate = self
        
        if mCell != nil { cell = mCell! }
        list[indexPath.row].viewHeight = cell.frame.height
        cell.contentView.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Row 별로 다양한 높이를 제공하기한 코드
        let list = self.tableList.filter{ $0.visible }
        return list[indexPath.row].viewHeight
//        return list[indexPath.row].viewHeight + 20
    }
}
struct InsiteViewModel {
    var nickName : String = ""
    var currentMonth : Int = 1
    var seenWorks : Int = 0
    var recordCount : Int = 0
}
